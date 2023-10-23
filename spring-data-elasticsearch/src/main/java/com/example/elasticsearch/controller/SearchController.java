package com.example.elasticsearch.controller;

import com.example.elasticsearch.model.dto.search.SearchHistoryResponse;
import com.example.elasticsearch.model.dto.search.SearchRankResponse;
import com.example.elasticsearch.model.dto.waiting.RestaurantWaitingStatusResponseDto;
import com.example.elasticsearch.model.dto.waiting.WaitingOneResponseDto;
import com.example.elasticsearch.model.service.SearchService;
import com.example.elasticsearch.model.dto.restaurant.RestaurantListResponse;
import com.example.elasticsearch.utils.RedisUtil;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/search")
public class SearchController {

    private final SearchService searchService;
    private final RedisUtil redisUtil;
    private final RedisTemplate redisTemplate;


    /* 동언 test */
    @GetMapping("/testOne")
    public ResponseEntity<?> testOne() throws  IOException, InterruptedException {
        WaitingOneResponseDto responseDto = searchService.testOne();
        return ResponseEntity.ok(responseDto);
    }

    /*검색기능*/
    @GetMapping("/contains")
    @Transactional(readOnly = false)
    public ResponseEntity<Map<String, List>> findByContainsDescription(
            @RequestHeader("userSeq") String userSeq,
            @RequestParam String description, String lon, String lat, Pageable pageable)
            throws  IOException, InterruptedException {
        // 단어 db 저장
        searchService.saveSearch(description);
        List<RestaurantListResponse> restaurantResponsesList = searchService.findByContainsDescription(userSeq, description,lon, lat, pageable);
        Map<String, List> resultMap = new HashMap<>();
        resultMap.put("result", restaurantResponsesList);
        return ResponseEntity.ok(resultMap);
    }

    /*실시간 순위 뽑아내는 로직*/
    @GetMapping("/top-search-keyword")
    @Transactional(readOnly = false)
    public ResponseEntity<List<SearchHistoryResponse>> SearchHistory () throws IOException {
        List<SearchHistoryResponse> searchHistoryListResponse = searchService.SearchHistory();
        return ResponseEntity.ok(searchHistoryListResponse);

    }

    @GetMapping("/top-search-keyword2")
    @Transactional(readOnly = false)
    public ResponseEntity<Map<Integer, String>> SearchHistoryToRedis () throws IOException {
        searchService.saveAllSearchDocuments();
        // 실시간 검색어 순위 추출
        List<SearchRankResponse> top = searchService.getTopSearchKeywords(10);
//        redisTemplate.delete("Ranking");
        for (SearchRankResponse n : top) {
            System.out.println(n.getSearchWord()+"____________________");
        }
        return null;
    }

}
