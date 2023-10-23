package com.simollu.CalculatorService.service;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.simollu.CalculatorService.dto.GetEstimatedTimeDto;
import com.simollu.CalculatorService.dto.GetEstimatedWaitingTimeDto;
import com.simollu.CalculatorService.entity.WaitingLog;
import com.simollu.CalculatorService.repository.WaitingLogRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.*;



@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class WaitingLogService {


    private final WaitingLogRepository waitingLogRepository;

    private static final Logger logger = LoggerFactory.getLogger(WaitingLogService.class);


    private final RedisTemplate<String, Object> redisTemplate;
    private final ObjectMapper objectMapper;




    // 타켓 날짜에 해당하는 모든 데이터를 가져오는 메소드
    public List<WaitingLog> findByTargetDate(LocalDate targetDate) {
        LocalDateTime startOfDay = targetDate.atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1).minusNanos(1);
        return waitingLogRepository.findByWaitingStatusRegistDateBetween(startOfDay, endOfDay);
    }



    // waitingLog 저장
    public void insertWaitingLog(WaitingLog waitingLog) {
        waitingLogRepository.save(waitingLog);
    }


    // ------------------------------------------------------------------------------------------------

    // 시간대별 예상 시간 계산 후 Redis에 cache로 저장
    // 1주전과 2주전의 데이터를 활용

    // 새벽 3시에 실행하는 스케줄링
    // @Scheduled(cron = "0 0 3 * * ?")


//    @Scheduled(cron = "0 01 22 * * ?")
//    public void test() {
//        System.out.println("안녕 나는 테스트야");
//        logger.info("Method 실행 시간: {}", LocalDateTime.now());
//    }

//    @Scheduled(cron = "0 * * * * ?")
//    public void test1() {
//        System.out.println("안녕 나는 테스트야2");
//        logger.info("Method 실행 시간: {}", LocalDateTime.now());
//    }


    // @Scheduled(cron = "0 30 5 * * ?")
    public Map<Long, Map<String, Double>> getAverageWaitingTime() throws JsonProcessingException {

        logger.info("평균 예상 시간 계산 함수 실행");
        logger.info("Method 실행 시간: {}", LocalDateTime.now());


        LocalDate today = LocalDate.now();
        LocalDate oneWeekAgo = today.minusWeeks(1);
        LocalDate twoWeeksAgo = today.minusWeeks(2);

        List<WaitingLog> waitingLogs = waitingLogRepository.findByWaitingStatusRegistDateBetween(
                LocalDateTime.of(twoWeeksAgo, LocalTime.MIN),
                LocalDateTime.of(oneWeekAgo, LocalTime.MAX));

        Map<Long, Map<String, Double>> resultMap = new HashMap<>();

        for (WaitingLog log : waitingLogs) {
            Long restaurantSeq = log.getRestaurantSeq();
            LocalDateTime registDate = log.getWaitingStatusRegistDate();
            long waitingTime = log.getWaitingLogTime();

            String timeSlot = registDate.toLocalTime().getHour() + ":00-" + (registDate.toLocalTime().getHour() + 1) + ":00";

            resultMap.computeIfAbsent(restaurantSeq, k -> new TreeMap<>());
            resultMap.get(restaurantSeq).compute(timeSlot, (k, v) -> v == null ? (double) waitingTime : Math.round((v + waitingTime) / 2.0));
        }


        for (Map.Entry<Long, Map<String, Double>> entry : resultMap.entrySet()) {
            String key = "averageWaitingTime:" + entry.getKey();

            // 기존 키가 있는 경우 삭제
            if (redisTemplate.hasKey(key)) {
                redisTemplate.delete(key);
            }


            HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
            Map<Object, Object> map = new HashMap<>();

            // 시간과 값을 가져와서 Redis에 저장
            for (Map.Entry<String, Double> timeEntry : entry.getValue().entrySet()) {
                String time = timeEntry.getKey();
                Double value = timeEntry.getValue();
                hashOps.put(key, time, value.toString());
            }



            // redisTemplate.opsForHash().putAll(key, entry.getValue());
        }

        Map<Object, Object> averageWaitingTime = getAverageWaitingTime(125);
        for(Object data : averageWaitingTime.keySet()) {
            System.out.println(data + " " + averageWaitingTime.get(data).toString());
        }

        return resultMap;
    }


    // 식당 예상 대기 시간
    public Map<Object, Object> getAverageWaitingTime(Integer restaurantSeq) {
        String key = "averageWaitingTime:" + restaurantSeq;
        HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
        return hashOps.entries(key);
    }







    // 시간별 순위가 오름에 따라 오르는 비율
    // 일주일, 이주일 전 데이터 사용
    // 대기시간 / 순위 의 비율을 구한 뒤 전체 순위에 또 평균값을 내서 구함
    // @Scheduled(cron = "0 40 5 * * ?")
    public Map<Long, Map<String, Double>> getAverageWaitingTimePerRank() {

        logger.info("평균 순위별 예상 시간 증가율 계산 함수 실행");
        logger.info("Method 실행 시간: {}", LocalDateTime.now());



        LocalDate today = LocalDate.now();
        LocalDate oneWeekAgo = today.minusWeeks(1);
        LocalDate twoWeeksAgo = today.minusWeeks(2);

        List<WaitingLog> waitingLogs = waitingLogRepository.findByWaitingStatusRegistDateBetween(
                LocalDateTime.of(twoWeeksAgo, LocalTime.MIN),
                LocalDateTime.of(oneWeekAgo, LocalTime.MAX));

        Map<Long, Map<String, Double>> resultMap = new HashMap<>();

        for (WaitingLog log : waitingLogs) {
            Long restaurantSeq = log.getRestaurantSeq();
            LocalDateTime registDate = log.getWaitingStatusRegistDate();
            long waitingTime = log.getWaitingLogTime();
            int waitingLogRank = log.getWaitingLogRank();

            long minutes = ChronoUnit.MINUTES.between(registDate.truncatedTo(ChronoUnit.HOURS), registDate);
            // String timeSlot = registDate.toLocalTime().getHour() + ":" + (minutes < 30 ? "00" : "30") + "~" + (minutes < 30 ? "18:29" : "59");
            String timeSlot = String.format("%02d:%02d ~ %02d:%02d", registDate.toLocalTime().getHour(), minutes < 30 ? 0 : 30, registDate.toLocalTime().getHour(), minutes < 30 ? 29 : 59);


            double waitingTimePerRank = (double) waitingTime / waitingLogRank;

            resultMap.computeIfAbsent(restaurantSeq, k -> new TreeMap<>());
            // resultMap.get(restaurantSeq).compute(timeSlot, (k, v) -> v == null ? waitingTimePerRank : Math.round((v + waitingTimePerRank) / 2.0));
            // resultMap.get(restaurantSeq).compute(timeSlot, (k, v) -> v == null ? waitingTimePerRank : Math.round(((v + waitingTimePerRank) / 2.0) * 100) / 100.0);
            resultMap.get(restaurantSeq).compute(timeSlot, (k, v) -> v == null ? waitingTimePerRank : Math.round(((v + waitingTimePerRank) / 2.0) * 10) / 10.0);

        }

        for (Map.Entry<Long, Map<String, Double>> entry : resultMap.entrySet()) {
            String key = "averageWaitingRatioTime:" + entry.getKey();

            // 기존 키가 있는 경우 삭제
            if (redisTemplate.hasKey(key)) {
                redisTemplate.delete(key);
            }

            // 새로운 값 저장
            redisTemplate.opsForHash().putAll(key, entry.getValue());
        }


        // 조회 함수
        Map<String, Double> dummy = getAverageWaitingTimeByRestaurantSeq(125);
        System.out.println(dummy.toString());
        for (String one : dummy.keySet()) {
            System.out.println(dummy.get(one));
        }

        return resultMap;
    }



    // Redis에 저장된 값 조회
    public Map<String, Double> getAverageWaitingTimeByRestaurantSeq(Integer restaurantSeq) {
        String key = "averageWaitingRatioTime:" + restaurantSeq;

        // Redis에서 해당 레스토랑의 평균 대기 시간 데이터를 가져옴
        Map<Object, Object> redisData = redisTemplate.opsForHash().entries(key);

        // Redis 데이터를 반환하기 위해 적절한 타입으로 변환
        Map<String, Double> resultMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : redisData.entrySet()) {
            resultMap.put((String) entry.getKey(), (Double) entry.getValue());
        }

        return resultMap;
    }








}
