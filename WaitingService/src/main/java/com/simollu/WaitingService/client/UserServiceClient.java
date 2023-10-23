package com.simollu.WaitingService.client;

import com.simollu.WaitingService.model.dto.user.RegisterUserForkRequestDto;
import com.simollu.WaitingService.model.dto.user.RegisterUserForkResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@FeignClient(name = "user-service")
public interface UserServiceClient {

    @PostMapping("/user/fork")
    RegisterUserForkResponseDto registerUserFork(@RequestHeader("userSeq") String userSeq,
                                                 @RequestBody RegisterUserForkRequestDto registerUserForkRequestDto);

}
