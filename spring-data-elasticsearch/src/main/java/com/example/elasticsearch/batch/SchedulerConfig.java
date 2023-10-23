package com.example.elasticsearch.batch;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;


@Configuration
@EnableScheduling
@RequiredArgsConstructor
public class SchedulerConfig {

    private final ScheduledTask scheduledTask;

    @Bean
    public TaskScheduler taskScheduler() {
        ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();
        taskScheduler.setPoolSize(1);
        return taskScheduler;
    }

    @Scheduled(fixedRate = 180000) // 3분마다 실행
    public void scheduleTask() throws IOException {
        scheduledTask.searchHistoryTask();
    }

    @Scheduled(fixedRate = 18000000) // 3분마다 실행
    public void scheduleTask2() throws IOException {
        scheduledTask.saveRating();
    }


}
