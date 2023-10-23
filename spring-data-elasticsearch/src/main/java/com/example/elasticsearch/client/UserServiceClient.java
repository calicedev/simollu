package com.example.elasticsearch.client;

import com.example.elasticsearch.model.dto.user.GetUserInfoListRequestDto;
import com.example.elasticsearch.model.dto.user.GetUserInfoListResponseDto;
import com.example.elasticsearch.model.dto.user.RegisterUserForkRequestDto;
import com.example.elasticsearch.model.dto.user.RegisterUserForkResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@FeignClient(name = "user-service")
public interface UserServiceClient {

    @PostMapping("/user/info-list")
    List<GetUserInfoListResponseDto> getUserInfoList(@RequestBody GetUserInfoListRequestDto userSeqList);

    @GetMapping("/user/restaurant/{restaurantSeq}")
    boolean checkUserRestaurant(@RequestHeader("userSeq") String userSeq, @PathVariable Long restaurantSeq);

    @PostMapping("/user/fork")
    RegisterUserForkResponseDto registerUserFork(@RequestHeader("userSeq") String userSeq,
                                                 @RequestBody RegisterUserForkRequestDto registerUserForkRequestDto);

}
