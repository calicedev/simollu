package com.simollu.WaitingService.scheduler;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component
@RequiredArgsConstructor
public class WaitingCleanupScheduler {

    private final RedisTemplate<String, Object> redisTemplate;

    @Scheduled(cron = "0 0 7 * * *") // 매일 아침 7시에 실행
    public void deleteKeysAtSpecificTime() {
        // 식당 웨이팅 대기가 남아있다면 삭제
        String pattern = "restaurant_no:*";
        Set<String> keys = redisTemplate.keys(pattern);
        if (keys != null && !keys.isEmpty()) {
            redisTemplate.delete(keys);
        }

        // 유저 웨이팅도 삭제
        String key = "u_waiting";
        redisTemplate.delete(key);

    }

}
