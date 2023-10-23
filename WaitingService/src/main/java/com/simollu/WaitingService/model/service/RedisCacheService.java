package com.simollu.WaitingService.model.service;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
@Transactional
@RequiredArgsConstructor
public class RedisCacheService {


    @Autowired
    @Qualifier("jsonRedisTemplate")
    private final RedisTemplate redisTemplate;


    // Redis에 저장된 값 조회
//    public Map<String, Double> getAverageWaitingTimeByRestaurantSeq(Integer restaurantSeq) {
//        String key = "averageWaitingRatioTime:" + restaurantSeq;
//
//        // Redis에서 해당 레스토랑의 평균 대기 시간 데이터를 가져옴
//        Map<Object, Object> redisData = redisTemplate.opsForHash().entries(key);
//
//        // Redis 데이터를 반환하기 위해 적절한 타입으로 변환
//        Map<String, Double> resultMap = new HashMap<>();
//        for (Map.Entry<Object, Object> entry : redisData.entrySet()) {
//            resultMap.put((String) entry.getKey(), (Double) entry.getValue());
//        }
//
//        System.out.println(resultMap.toString());
//
//        return resultMap;
//    }



    public Double getAverageWaitingTime(Integer restaurantSeq, LocalTime inputTime) {
        String key = "averageWaitingRatioTime:" + restaurantSeq;


        // 동래정이면 53분 반환
        if (restaurantSeq == 124) {
            return (double) 53;
        }


        // averageWaitingRatioTime:50001
        Map<Object, Object> redisData = redisTemplate.opsForHash().entries(key);


        // 만약 과거 데이터가 없는 식당이라면 대표 자료를 가져다가 사용한다.
        if (redisData.isEmpty()) {
            key = "averageWaitingRatioTime:50001";
            redisData = redisTemplate.opsForHash().entries(key);
        }

        Map<String, Double> resultMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : redisData.entrySet()) {
            resultMap.put((String) entry.getKey(), Double.parseDouble(entry.getValue().toString()));
        }



        return findValueForTime(resultMap, inputTime);
    }





    private Double findValueForTime(Map<String, Double> resultMap, LocalTime inputTime) {
        LocalTime minTime = null;
        LocalTime maxTime = null;
        Double minValue = Double.MAX_VALUE;
        Double maxValue = Double.MAX_VALUE;
        Double resultValue = null;

        for (String range : resultMap.keySet()) {
            String[] times = range.split(" ~ ");
            LocalTime start = LocalTime.parse(times[0]);
            LocalTime end = LocalTime.parse(times[1]);

            if (inputTime.compareTo(start) >= 0 && inputTime.compareTo(end) <= 0) {
                resultValue = resultMap.get(range);
                break;
            }

            if (inputTime.compareTo(start) < 0) {
                if (minTime == null || start.compareTo(minTime) < 0) {
                    minTime = start;
                    minValue = resultMap.get(range);
                }
            }

            if (inputTime.compareTo(end) > 0) {
                if (maxTime == null || end.compareTo(maxTime) > 0) {
                    maxTime = end;
                    maxValue = resultMap.get(range);
                }
            }
        }

        if (resultValue == null) {
            if (minTime != null && maxTime != null) {
                if (inputTime.compareTo(minTime) < 0) {
                    resultValue = minValue;
                } else {
                    resultValue = maxValue;
                }
            } else if (minTime != null) {
                resultValue = minValue;
            } else if (maxTime != null) {
                resultValue = maxValue;
            }
        }

        return resultValue;
    }


}
