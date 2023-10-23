package com.example.elasticsearch.model.service;

import com.example.elasticsearch.aws.AwsS3Repository;
import com.example.elasticsearch.client.UserServiceClient;
import com.example.elasticsearch.client.WaitingClientService;
import com.example.elasticsearch.model.dto.main.RestaurantMainInfoListResponse;
import com.example.elasticsearch.model.dto.main.RestaurantMainThemeInfoResponse;
import com.example.elasticsearch.model.dto.menu.MenuInfoResponse;
import com.example.elasticsearch.model.dto.restaurant.RestaurantFavoriteResponse;
import com.example.elasticsearch.model.dto.restaurant.RestaurantInfoResponse;
import com.example.elasticsearch.model.dto.main.RestaurantMainInfoResponse;
import com.example.elasticsearch.model.dto.restaurant.WaitingTimeResponse;
import com.example.elasticsearch.model.dto.search.SearchInfoResponse;
import com.example.elasticsearch.model.dto.waiting.WaitingOneResponseDto;
import com.example.elasticsearch.model.entity.Menu;
import com.example.elasticsearch.model.entity.Restaurant;
import com.example.elasticsearch.model.document.RestaurantDocument;
import com.example.elasticsearch.repository.elkAdvance.SearchElasticAdvanceRepository;
import com.example.elasticsearch.repository.jpa.MenuJpaRepository;
import com.example.elasticsearch.repository.jpa.RestaurantJpaRepository;
import com.example.elasticsearch.repository.elkBasic.RestaurantElasticBasicRepository;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RestaurantService {

    private final RestaurantJpaRepository restaurantJpaRepository;
    private final MenuJpaRepository menuJpaRepository;
    private final RestaurantElasticBasicRepository restaurantElasticBasicRepository;
    private final SearchElasticAdvanceRepository searchElasticAdvanceRepository;
    private final AwsS3Repository awsS3Repository;
    @Qualifier("jsonRedisTemplate")
    private final RedisTemplate<String, Object> redisTemplate;
    private final WaitingClientService waitingClientService;
    private final UserServiceClient userServiceClient;


    // 시간 계산
    public int getWaitingTime(Long restaurantSeq) {
        WaitingOneResponseDto restaurantWaitingStatus = waitingClientService.getRestaurantWaitingStatus(restaurantSeq);
        return restaurantWaitingStatus.getWaitingTime();


    }

    // MYSQL -> ELK
    @Transactional
    public void saveAllRestaurantDocuments() throws IOException {
        List<RestaurantDocument> restaurantDocumentList = new ArrayList<>();
        List<Restaurant> restaurantList = restaurantJpaRepository.findAll();
        for (Restaurant restaurant : restaurantList) {
            RestaurantDocument document = RestaurantDocument.from(restaurant);
            restaurantDocumentList.add(document);
        }
        restaurantElasticBasicRepository.saveAll(restaurantDocumentList);
    }

    //레스토랑 상세검색
    public SearchInfoResponse getSearchInfo(String userSeq, Long restaurantSeq) {
        SearchInfoResponse searchInfoResponse = SearchInfoResponse.builder()
                .restaurantInfo(getRestaurantInfo(userSeq, restaurantSeq))
                .menuInfoList(getMenuInfo(restaurantSeq))
                .waitingTimeList(getWaitingTimeList(restaurantSeq))
                .build();
        return searchInfoResponse;
    }

    // 레스토랑 상세검색 -> 대기 시간 리스트
    private List<WaitingTimeResponse> getWaitingTimeList(Long restaurantSeq) {
        String key = "averageWaitingTime:" + restaurantSeq;
        HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
        Map<Object, Object> s = hashOps.entries(key);
        List<WaitingTimeResponse> response = new ArrayList<>();
        for (Object data : s.keySet()) {
            WaitingTimeResponse w = WaitingTimeResponse.builder()
                    .timeZone((String) data)
                    .expectedWaitingTime((int)Double.parseDouble(s.get(data).toString()))
                .build();
            response.add(w);
        }
        return response;
    }

    // 레스토랑 상세검색 -> 레스토랑 정보
    /* 동언 관심식당  */
    public RestaurantInfoResponse getRestaurantInfo(String userSeq, long restaurantSeq){



        Restaurant restaurant = restaurantJpaRepository.findByRestaurantSeq(restaurantSeq);
        RestaurantInfoResponse restaurantInfoResponse = RestaurantInfoResponse.builder()
                .restaurantAddress(restaurant.getRestaurantAddress())
                .restaurantImg(awsS3Repository.getTemporaryUrl(restaurant.getRestaurantImg()))
                .restaurantName(restaurant.getRestaurantName())
                .restaurantCategory(restaurant.getRestaurantCategory())
                .restaurantRating(restaurant.getRestaurantRating())
                .restaurantBusinessHours(restaurant.getRestaurantBusinessHours())
                .restaurantSeq(restaurant.getRestaurantSeq())
                .restaurantPhoneNumber(restaurant.getRestaurantPhoneNumber())
                .restaurantLike(checkUserLike(userSeq, restaurantSeq))
                .restaurantY(restaurant.getRestaurantY())
                .restaurantX(restaurant.getRestaurantX())
                .build();
        return restaurantInfoResponse;
    }

    // 레스토랑 상세검색 -> 레스토랑 메뉴 정보
    public List<MenuInfoResponse> getMenuInfo(long restaurantSeq){
        List<MenuInfoResponse> menuInfoResponseList = new ArrayList<>();
        List<Menu> menues = menuJpaRepository.findByRestaurantSeq(restaurantSeq);
        for(Menu m : menues){
            MenuInfoResponse menuInfoResponse = MenuInfoResponse.builder()
                    .menuImage(awsS3Repository.getTemporaryUrl(m.getMenuImage()))
                    .menuSeq(m.getMenuSeq())
                    .menuPrice(m.getMenuPrice())
                    .menuName(m.getMenuName())
                    .build();
            menuInfoResponseList.add(menuInfoResponse);
        }
        return menuInfoResponseList;
    }

    // 메인 화면 정보
    @Transactional
    public RestaurantMainInfoListResponse getMainInfo(String userSeq, Double lat, Double lon) {
        RestaurantMainInfoListResponse restaurantMainInfoListResponse = RestaurantMainInfoListResponse.builder()
                .restaurantNearByList(getRestaurantNearByList(userSeq, lat,lon))
                .restaurantHighRatingList(getRestaurantHighRatingList(userSeq, lat,lon))
                .restaurantLessWaitingList(getRestaurantLessWaitingList(userSeq, lat,lon))
                .koreanFoodTopList(getRestaurantThemeList(userSeq,lat, lon, "한식"))
                .westernFoodTopList(getRestaurantThemeList(userSeq, lat, lon, "양식"))
                .chineseTopList(getRestaurantThemeList(userSeq, lat, lon, "증식"))
                .japanesTopList(getRestaurantThemeList(userSeq, lat, lon, "일식"))
                .fastFoodTopList(getRestaurantThemeList(userSeq, lat, lon, "패스트푸드"))
                .cafeTopList(getRestaurantThemeList(userSeq, lat, lon, "카페"))
                .bakeryTopList(getRestaurantThemeList(userSeq, lat, lon, "베이커리"))
                .build();
        return restaurantMainInfoListResponse;

    }



    public class RestaurantWaitingTime implements Comparable<RestaurantWaitingTime> {
        private final Long restaurantSeq;
        private final int waitingTime;

        public RestaurantWaitingTime(Long restaurantSeq, int waitingTime) {
            this.restaurantSeq = restaurantSeq;
            this.waitingTime = waitingTime;
        }

        public Long getRestaurantSeq() {
            return restaurantSeq;
        }

        public int getWaitingTime() {
            return waitingTime;
        }

        @Override
        public int compareTo(RestaurantWaitingTime other) {
            // 내림차순 정렬
            return Integer.compare(other.waitingTime, this.waitingTime);
        }
    }

    private List<RestaurantMainInfoResponse> getRestaurantLessWaitingList(String userSeq, Double lat, Double lon) {
        List<RestaurantDocument> restaurantDocument = searchElasticAdvanceRepository.findLessWaitingRestaurant(lat,lon);
        List<RestaurantWaitingTime> restaurantWaitingTimes = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            restaurantWaitingTimes.add(new RestaurantWaitingTime(r.getRestaurantSeq(), getWaitingTime(r.getRestaurantSeq())));
        }
        Collections.sort(restaurantWaitingTimes);
        List<RestaurantMainInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for (RestaurantWaitingTime rwt : restaurantWaitingTimes) {
            Restaurant restaurant = restaurantJpaRepository.findByRestaurantSeq(rwt.restaurantSeq);
            RestaurantMainInfoResponse restaurantMainInfoResponse = RestaurantMainInfoResponse.builder()
                    .restaurantSeq(restaurant.getRestaurantSeq())
                    .restaurantName(restaurant.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(restaurant.getRestaurantImg()))
                    .restaurantRating(restaurant.getRestaurantRating())
                    .restaurantWaitingTime(getWaitingTime(restaurant.getRestaurantSeq()))
                    .restaurantWaitingTime(rwt.waitingTime)
                    .restaurantLike(checkUserLike(userSeq, restaurant.getRestaurantSeq()))
                    .build();
            restaurantMainInfoList.add(restaurantMainInfoResponse);
        }
        return restaurantMainInfoList;
    }

    private List<RestaurantMainThemeInfoResponse> getRestaurantThemeList(String userSeq, Double lat, Double lon, String theme) {
        List<RestaurantDocument> restaurantDocument = searchElasticAdvanceRepository.findThemeRestaurantsNearby(lat,lon,theme);
        List<RestaurantMainThemeInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            RestaurantMainThemeInfoResponse restaurantMainInfoResponse = RestaurantMainThemeInfoResponse.builder()
                    .restaurantSeq(r.getRestaurantSeq())
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    .restaurantWaitingTime(getWaitingTime(r.getRestaurantSeq()))
                    .restaurantAddress(slicingAddress(r.getRestaurantAddress()))
                    .distance(calculateDistance(lat, lon, Double.parseDouble(r.getRestaurantY()), Double.parseDouble(r.getRestaurantX())))
                    .restaurantLike(checkUserLike(userSeq, r.getRestaurantSeq()))
                    .build();
            restaurantMainInfoList.add(restaurantMainInfoResponse);
        }
        return restaurantMainInfoList;
    }

    private List<RestaurantMainInfoResponse> getRestaurantHighRatingList(String userSeq, Double lat, Double lon) {
        List<RestaurantDocument> restaurantDocument = searchElasticAdvanceRepository.findTopRatedRestaurantsNearby(lat,lon);
        List<RestaurantMainInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            RestaurantMainInfoResponse restaurantMainInfoResponse = RestaurantMainInfoResponse.builder()
                    .restaurantSeq(r.getRestaurantSeq())
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    .restaurantWaitingTime(getWaitingTime(r.getRestaurantSeq()))
                    .restaurantLike(checkUserLike(userSeq, r.getRestaurantSeq()))
                    .build();
            restaurantMainInfoList.add(restaurantMainInfoResponse);
        }
        return restaurantMainInfoList;
    }


    private List<RestaurantMainInfoResponse> getRestaurantNearByList(String userSeq, Double lat, Double lon) {
        List<RestaurantDocument> restaurantDocument =  searchElasticAdvanceRepository.findNearestRestaurants(lat,lon);
        List<RestaurantMainInfoResponse> restaurantMainInfoList = new ArrayList<>();
        for(RestaurantDocument r : restaurantDocument){
            RestaurantMainInfoResponse restaurantMainInfoResponse = RestaurantMainInfoResponse.builder()
                    .restaurantSeq(r.getRestaurantSeq())
                    .restaurantName(r.getRestaurantName())
                    .restaurantImage(awsS3Repository.getTemporaryUrl(r.getRestaurantImg()))
                    .restaurantRating(r.getRestaurantRating())
                    .restaurantWaitingTime(getWaitingTime(r.getRestaurantSeq()))
                    .restaurantLike(checkUserLike(userSeq, r.getRestaurantSeq()))
                    .build();
            restaurantMainInfoList.add(restaurantMainInfoResponse);
        }

        return restaurantMainInfoList;
    }

    public List<Long> getRestaurantSeq() {
        List<Restaurant> restaurants = restaurantJpaRepository.findAll();
        List<Long> responseSeq = new ArrayList<>();
        for(Restaurant r : restaurants){
            responseSeq.add(r.getRestaurantSeq());
        }
        return responseSeq;
    }


    public RestaurantFavoriteResponse  getRestaurantFavorite(String userSeq, Long restaurantSeq) {
            Restaurant restaurant = restaurantJpaRepository.findByRestaurantSeq(restaurantSeq);
            RestaurantFavoriteResponse restaurantFavoriteResponse = RestaurantFavoriteResponse.builder()
                    .restaurantSeq(restaurant.getRestaurantSeq())
                    .restaurantName(restaurant.getRestaurantName())
                    .restaurantAddress(slicingAddress(restaurant.getRestaurantAddress()))
                    .restaurantRating(restaurant.getRestaurantRating())
                    .restaurantCategory(restaurant.getRestaurantCategory())
                    .restaurantImg(restaurant.getRestaurantImg())
                    .restaurantLike(checkUserLike(userSeq, restaurantSeq))
                    .build();
        return restaurantFavoriteResponse;
    }

    private String slicingAddress(String restaurantAddress) {
        String[] parts = restaurantAddress.split(" "); // 공백을 기준으로 문자열을 여러 부분으로 나눕니다.

        String slicedAddress = "";
        for (int i = 0; i < parts.length; i++) {
            if (i < 2) { // 첫 번째와 두 번째 부분만 결합합니다.
                slicedAddress += parts[i] + " ";
            }
        }
        return slicedAddress.trim();
    }

    public static double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
        double earthRadiusKm = 6371.0;
        double dLat = Math.toRadians(endLat - startLat);
        double dLng = Math.toRadians(endLng - startLng);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(Math.toRadians(startLat)) * Math.cos(Math.toRadians(endLat)) * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distanceInKm = earthRadiusKm * c;

        // 반올림하여 소수점 둘째 자리까지 표시
        BigDecimal bd = new BigDecimal(distanceInKm).setScale(2, RoundingMode.HALF_UP);
        BigDecimal roundedDistance = bd.add(new BigDecimal(0.2)).setScale(2, RoundingMode.HALF_UP); // 덧셈도 BigDecimal을 사용하여 수행

        return roundedDistance.doubleValue();
    }



    // 회원과 식당에 관심 식당 등록 여부 파악
    public boolean checkUserLike(String userSeq, Long restaurantSeq) {
        return userServiceClient.checkUserRestaurant(userSeq,restaurantSeq);
    }

}
