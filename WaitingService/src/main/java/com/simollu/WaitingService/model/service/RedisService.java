package com.simollu.WaitingService.model.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.simollu.WaitingService.model.dto.WaitingDetailDto;
import com.simollu.WaitingService.model.dto.WaitingHistoryDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.io.IOException;
import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class RedisService {

    private final RedisTemplate<String, Object> redisTemplate;
    private final ObjectMapper objectMapper;

    private final String USER_KEY = "u_waiting";

    private static final String RESTAURANT_KEY = "restaurant_no:";
    private static final Duration EXPIRATION_DURATION = Duration.ofDays(1);

    private static final int STATUS_WAITING = 0;
    private static final int STATUS_CHANGE = 3;
    private static final int STATUS_DELETE = -1;

    public RedisService(RedisTemplate<String, Object> redisTemplate, ObjectMapper objectMapper) {
        this.redisTemplate = redisTemplate;
        this.objectMapper = objectMapper;
        objectMapper.registerModule(new JavaTimeModule());
    }

    public <T> T getRedisValue(Integer restaurantSeq,Class<T> classType) throws JsonProcessingException {
        String key = RESTAURANT_KEY + restaurantSeq;
        String redisValue = (String) redisTemplate.opsForValue().get(key);
        if (ObjectUtils.isEmpty(redisValue)) {
            return null;
        }else{
            return objectMapper.readValue(redisValue,classType);
        }
    }

    public void putRedis(String key,Object classType) throws JsonProcessingException {
        redisTemplate.opsForValue().set(key, objectMapper.writeValueAsString(classType));
    }

    public <T> T getRedisListValue(Integer restaurantSeq, Long index,Class<T> classType) throws JsonProcessingException {
        String key = RESTAURANT_KEY + restaurantSeq;
        String redisValue = (String) redisTemplate.opsForList().index(key, index);
        if (ObjectUtils.isEmpty(redisValue)) {
            return null;
        }else{
            return objectMapper.readValue(redisValue,classType);
        }
    }

    public void putRedisList(Integer restaurantSeq,Object classType) throws JsonProcessingException {
        String key = RESTAURANT_KEY + restaurantSeq;
        redisTemplate.opsForList().rightPush(key, objectMapper.writeValueAsString(classType));
        redisTemplate.expire(key, EXPIRATION_DURATION);
    }

    /* list 구하기 */
    public List<Object> getRedisList(String key) {
//        Long size = redisTemplate.opsForList().size(key);
        return redisTemplate.opsForList().range(key, 0, -1);
    }//getRedisList

    // 해당 웨이팅 인덱스 구하기
    public int getIndex(Integer restaurantSeq, Integer waitingSeq) {
        String key = RESTAURANT_KEY + restaurantSeq;
        List<Object> list = getRedisList(key);
        if(list.size() == 0) return -1;

        int idx = 0;
        try {
            for(Object obj : list){
                WaitingHistoryDto waiting = WaitingHistoryDto.JsonToDto((String)obj);
                idx++;
                if(waiting.getWaitingSeq() == waitingSeq) break;
            }//for
        }catch (IOException e) {
            log.error("index 구하기 error");
        }
        return idx;
    }

    /* 취소/완료/순서미루기 시 redis 에서 데이터 삭제 */
    public WaitingHistoryDto deleteWaiting(Integer restaurantSeq, Integer waitingSeq, int status) {
        String key = RESTAURANT_KEY + restaurantSeq;
        WaitingHistoryDto waiting = new WaitingHistoryDto();

        int idx = getIndex(restaurantSeq, waitingSeq);
        if(idx == -1) return waiting;

        Object obj = redisTemplate.opsForList().index(key, idx-1);
        try {
            waiting = WaitingHistoryDto.JsonToDto((String)obj);
        }catch (IOException e) {

        }

        redisTemplate.opsForList().remove(key, 1, obj);

        // redis 에서 개인 웨이팅정보도 삭제
        WaitingDetailDto detailDto = getWaiting(waiting.getUserSeq());
        if(status == STATUS_CHANGE) {
            detailDto.setWaitingStatusContent(STATUS_CHANGE);
            try {
                saveUserWaitingToRedis(waiting.getUserSeq(), detailDto);
            }catch (JsonProcessingException e) {
                log.error("미루기 데이터 갱신 error");
            }
        }else {
            if(redisTemplate.opsForHash().get(USER_KEY, detailDto.getUserSeq()) != null){
                redisTemplate.opsForHash().delete(USER_KEY, detailDto.getUserSeq());
            }
        }

        return waiting;
    }

    /* 대기팀 수 구하기 */
    public Integer getWaitingCnt(Integer restaurantSeq) {
        String key = RESTAURANT_KEY + restaurantSeq;
        long cnt = redisTemplate.opsForList().size(key);

        if(cnt == -1) return 0;
        return Math.toIntExact(cnt);
    }//getWatitingCnt

    // Map 데이터를 Redis에 저장
    public void saveDataToRedis(String key) {
        // Redis HashOperations를 사용하여 Map 데이터를 Redis에 저장합니다.
        HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
        Map<String, String> map = new HashMap<>();
        hashOps.putAll(USER_KEY, map);
        Map<Object, Object> m = hashOps.entries(key);
        redisTemplate.expire(USER_KEY, EXPIRATION_DURATION);
    }

    public void saveUserWaitingToRedis(String key, Object classType) throws JsonProcessingException  {
        HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
        Map<Object, Object> map = hashOps.entries(USER_KEY);
        map.put(key, objectMapper.writeValueAsString(classType));
        hashOps.putAll(USER_KEY, map);
        redisTemplate.expire(USER_KEY, EXPIRATION_DURATION);
    }

    // 순서 미루기 사용 여부 확인
    public int getStatus(String key) {
        HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
        int status = -1;
        try {
            WaitingDetailDto dto = WaitingDetailDto.JsonToDto((String) hashOps.get(USER_KEY, key));
            status =  dto.getWaitingStatusContent();
        }catch (IOException e){

        }

        return status;
    }

    // 웨이팅 조회
    public WaitingDetailDto getWaiting(String key) {
        HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
        WaitingDetailDto dto = null;
        try {
            dto = WaitingDetailDto.JsonToDto((String)hashOps.get(USER_KEY, key));
        }catch (IOException e){
            log.error("웨이팅 조회");
            log.error(e.getMessage());
        }
        return dto;
    }

}//RedisService
