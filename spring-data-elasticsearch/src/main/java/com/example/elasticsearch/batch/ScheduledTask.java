package com.example.elasticsearch.batch;

import com.example.elasticsearch.model.dto.search.SearchRankResponse;
import com.example.elasticsearch.model.service.RestaurantService;
import com.example.elasticsearch.model.service.SearchService;
import com.example.elasticsearch.repository.elkAdvance.SearchElasticAdvanceRepository;
import com.example.elasticsearch.utils.RedisUtil;
import java.io.IOException;
import java.util.List;

import lombok.RequiredArgsConstructor;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = false)
public class ScheduledTask {

    private final SearchService searchService;
    private final RestaurantService restaurantService;
    private final SearchElasticAdvanceRepository searchElasticAdvanceRepository;
    private final RedisTemplate redisTemplate;

    public void searchHistoryTask() throws IOException {
        // 단어 es 저장
        searchService.saveAllSearchDocuments();
        // 실시간 검색어 순위 추출
        List<SearchRankResponse> top = searchService.getTopSearchKeywords(10);
        redisTemplate.delete("Ranking");
        for(SearchRankResponse n : top){
            redisTemplate.opsForList().rightPush("Ranking", n.getSearchWord());
        }
    }

    public void saveRating() throws IOException {
        // 단어 es 저장
        List<Long> seq = restaurantService.getRestaurantSeq();
        for(Long s : seq){
            int rating = calculateRating(s);
            searchElasticAdvanceRepository.updateRestaurantRating(s,rating);
        }
    }


    public int calculateRating(Long restaurantSeq) {
        Integer f = (Integer) redisTemplate.opsForHash().get("review", restaurantSeq+"_false");
        Integer t = (Integer) redisTemplate.opsForHash().get("review", restaurantSeq+"_true");
        System.out.println(f);
        System.out.println(t);
        System.out.println("here");
        int percentage = 0;
        if (t != 0) {
            System.out.println();
            double ratio = (double) t / (t + f);
            percentage = (int) (ratio * 100);
        }
        return percentage;
    }
}
