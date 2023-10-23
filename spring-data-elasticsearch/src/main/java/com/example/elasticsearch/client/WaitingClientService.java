package com.example.elasticsearch.client;


import com.example.elasticsearch.model.dto.waiting.RestaurantWaitingStatusRequestDto;
import com.example.elasticsearch.model.dto.waiting.RestaurantWaitingStatusResponseDto;
import com.example.elasticsearch.model.dto.waiting.WaitingOneResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

// name 에는 마이크로서비스의 이름 등록
@FeignClient(name = "waiting-service")
public interface WaitingClientService {

    @GetMapping("/user/restaurant-status/{restaurantSeq}")
    WaitingOneResponseDto getRestaurantWaitingStatus(@PathVariable("restaurantSeq") Long restaurantSeq);


}
