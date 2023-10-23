package com.example.elasticsearch.repository.elkAdvance;

import com.example.elasticsearch.model.document.RestaurantDocument;
import com.example.elasticsearch.model.document.SearchDocument2;
import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.elasticsearch.action.DocWriteResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.update.UpdateRequest;
import org.elasticsearch.action.update.UpdateResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.unit.DistanceUnit;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.GeoDistanceQueryBuilder;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.elasticsearch.search.aggregations.AggregationBuilder;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.BucketOrder;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.GeoDistanceSortBuilder;
import org.elasticsearch.search.sort.SortBuilders;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.query.Query;
import org.springframework.stereotype.Repository;

import java.util.*;
import java.util.stream.Collectors;
import org.elasticsearch.index.query.QueryBuilders;

@Repository
@RequiredArgsConstructor
public class SearchElasticAdvanceRepository {
    private final RestHighLevelClient restHighLevelClient;
    private final ElasticsearchRestTemplate elasticsearchRestTemplate;
    private final ObjectMapper objectMapper = new ObjectMapper();
    public List<RestaurantDocument> findByDescription(String des, String lon, String lat, Pageable pageable) {
        // ElasticsearchTemplate을 사용하여 검색 쿼리 생성
        Query searchQuery = new NativeSearchQueryBuilder()
                .withQuery(QueryBuilders.multiMatchQuery(des, "restaurantName", "restaurantCategory", "restaurantAddress"))
                .build();

        // ElasticsearchTemplate으로 검색 실행
        SearchHits<RestaurantDocument> searchHits = elasticsearchRestTemplate.search(searchQuery, RestaurantDocument.class);

        // 검색 결과를 리스트로 반환
        return searchHits.stream().map(SearchHit::getContent).collect(Collectors.toList());
    }
    public List<SearchDocument2> findTopSearchKeywords(int topN) {
        AggregationBuilder aggregationBuilder = AggregationBuilders.terms("top_keywords")
                .field("searchWord.keyword")
                .size(topN)
                .order(BucketOrder.count(false));

        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.aggregation(aggregationBuilder);

        SearchRequest searchRequest = new SearchRequest("search");
        searchRequest.source(searchSourceBuilder);

        try {
            SearchResponse searchResponse = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);
            Terms terms = searchResponse.getAggregations().get("top_keywords");
            return terms.getBuckets().stream()
                    .map(bucket -> new SearchDocument2(null, bucket.getKeyAsString()))
                    .collect(Collectors.toList());
        } catch (IOException e) {
            throw new RuntimeException("Error occurred while fetching top search keywords.", e);
        }
    }

    public List<RestaurantDocument> findNearestRestaurants(double latitude, double longitude) {
        int limit = 5; // 최대 검색 결과 개수

        // 가장 가까운 순서대로 정렬하기 위한 설정
        GeoDistanceSortBuilder sortBuilder = SortBuilders.geoDistanceSort("location", latitude, longitude)
                .order(SortOrder.ASC)
                .unit(DistanceUnit.KILOMETERS);

        // 검색 쿼리 설정
        GeoDistanceQueryBuilder queryBuilder = new GeoDistanceQueryBuilder("location")
                .point(latitude, longitude)
                .distance(5, DistanceUnit.KILOMETERS); // 5km 반경 내의 레스토랑 검색

        // 검색 요청 생성
        SearchRequest searchRequest = new SearchRequest("restaurant");
        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder()
                .query(queryBuilder)
                .size(limit)
                .sort(sortBuilder);
        searchRequest.source(sourceBuilder);

        try {
            // Elasticsearch에 검색 요청 후 결과 받기
            SearchResponse searchResponse = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);

            // 검색 결과 파싱
            List<RestaurantDocument> restaurantList = new ArrayList<>();
            searchResponse.getHits().forEach(hit -> {
                RestaurantDocument restaurant = new ObjectMapper().convertValue(hit.getSourceAsMap(), RestaurantDocument.class);
                restaurantList.add(restaurant);
            });

            return restaurantList;
        } catch (IOException e) {
            throw new RuntimeException("Error occurred while searching restaurants.", e);
        }
    }

    public void updateRestaurantRating(Long restaurantSeq, double newRating) {
        // 수정할 문서의 ID와 새로운 rating 값을 매핑
        Map<String, Object> sourceMap = new HashMap<>();
        sourceMap.put("restaurantRating", newRating);

        // 업데이트 요청 생성
        UpdateRequest updateRequest = new UpdateRequest("restaurant", String.valueOf(restaurantSeq))
                .doc(sourceMap);

        try {
            // Elasticsearch에 업데이트 요청 후 결과 받기
            UpdateResponse updateResponse = restHighLevelClient.update(updateRequest, RequestOptions.DEFAULT);
            if (updateResponse.getResult() != DocWriteResponse.Result.UPDATED) {
                throw new RuntimeException("Failed to update restaurant rating.");
            }
        } catch (IOException e) {
            throw new RuntimeException("Error occurred while updating restaurant rating.", e);
        }
    }

    public List<RestaurantDocument> findTopRatedRestaurantsNearby(double latitude, double longitude) {
        int limit = 5; // 최대 검색 결과 개수

        // 레스토랑 평점을 내림차순으로 정렬하는 설정
        FieldSortBuilder ratingSortBuilder = SortBuilders.fieldSort("restaurantRating")
                .order(SortOrder.DESC);

        // 검색 쿼리 설정: 3km 반경 내의 레스토랑 검색
        GeoDistanceQueryBuilder queryBuilder = new GeoDistanceQueryBuilder("location")
                .point(latitude, longitude)
                .distance(3, DistanceUnit.KILOMETERS);

        // 검색 요청 생성
        SearchRequest searchRequest = new SearchRequest("restaurant");
        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder()
                .query(queryBuilder)
                .size(limit)
                .sort(ratingSortBuilder); // 레스토랑 평점에 대한 정렬 추가
        searchRequest.source(sourceBuilder);

        try {
            // Elasticsearch에 검색 요청 후 결과 받기
            SearchResponse searchResponse = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);

            // 검색 결과 파싱
            List<RestaurantDocument> restaurantList = new ArrayList<>();
            searchResponse.getHits().forEach(hit -> {
                RestaurantDocument restaurant = new ObjectMapper().convertValue(hit.getSourceAsMap(), RestaurantDocument.class);
                restaurantList.add(restaurant);
            });

            return restaurantList;
        } catch (IOException e) {
            throw new RuntimeException("Error occurred while searching restaurants.", e);
        }
    }

    public List<RestaurantDocument> findThemeRestaurantsNearby(double latitude, double longitude, String theme) {
        int limit = 5; // 최대 검색 결과 개수

        // 레스토랑 평점을 내림차순으로 정렬하는 설정
        FieldSortBuilder ratingSortBuilder = SortBuilders.fieldSort("restaurantRating")
                .order(SortOrder.DESC);

        // 한식 카테고리를 필터링하는 쿼리 생성
        MatchQueryBuilder categoryQuery = QueryBuilders.matchQuery("restaurantCategory", theme);

        // 검색 쿼리 설정: 10km 반경 내의 한식 레스토랑 검색
        GeoDistanceQueryBuilder distanceQuery = QueryBuilders.geoDistanceQuery("location")
                .point(latitude, longitude)
                .distance(10, DistanceUnit.KILOMETERS);

        // 카테고리 쿼리와 거리 쿼리를 결합
        BoolQueryBuilder queryBuilder = QueryBuilders.boolQuery()
                .must(categoryQuery)
                .filter(distanceQuery);

        // 검색 요청 생성
        SearchRequest searchRequest = new SearchRequest("restaurant");
        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder()
                .query(queryBuilder)
                .size(limit)
                .sort(ratingSortBuilder); // 레스토랑 평점에 대한 정렬 추가
        searchRequest.source(sourceBuilder);

        try {
            // Elasticsearch에 검색 요청 후 결과 받기
            SearchResponse searchResponse = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);

            // 검색 결과 파싱
            List<RestaurantDocument> restaurantList = new ArrayList<>();
            searchResponse.getHits().forEach(hit -> {
                RestaurantDocument restaurant = new ObjectMapper().convertValue(hit.getSourceAsMap(), RestaurantDocument.class);
                restaurantList.add(restaurant);
            });

            return restaurantList;
        } catch (IOException e) {
            throw new RuntimeException("Error occurred while searching restaurants.", e);
        }
    }

    public List<RestaurantDocument> findLessWaitingRestaurant(Double lat, Double lon) {
        int limit = 5; // 최대 검색 결과 개수

        // 레스토랑 평점을 내림차순으로 정렬하는 설정

        // 검색 쿼리 설정: 3km 반경 내의 레스토랑 검색
        GeoDistanceQueryBuilder queryBuilder = new GeoDistanceQueryBuilder("location")
                .point(lat, lon)
                .distance(1, DistanceUnit.KILOMETERS);

        // 검색 요청 생성
        SearchRequest searchRequest = new SearchRequest("restaurant");
        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder()
                .query(queryBuilder)
                .size(limit);
        searchRequest.source(sourceBuilder);

        try {
            // Elasticsearch에 검색 요청 후 결과 받기
            SearchResponse searchResponse = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);

            // 검색 결과 파싱
            List<RestaurantDocument> restaurantList = new ArrayList<>();
            searchResponse.getHits().forEach(hit -> {
                RestaurantDocument restaurant = new ObjectMapper().convertValue(hit.getSourceAsMap(), RestaurantDocument.class);
                restaurantList.add(restaurant);
            });

            return restaurantList;
        } catch (IOException e) {
            throw new RuntimeException("Error occurred while searching restaurants.", e);
        }
    }
}

