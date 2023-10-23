package com.simollu.WaitingService.controller;

import com.simollu.WaitingService.model.dto.RestaurantWaitingStatusRequestDto;
import com.simollu.WaitingService.model.dto.RestaurantWaitingStatusResponseDto;
import com.simollu.WaitingService.model.dto.RestaurantWaitingTimeResponseDto;
import com.simollu.WaitingService.model.service.WaitingService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.coyote.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/public")
@RequiredArgsConstructor
@Slf4j
@Api(tags = "Waiting API")
public class WaitingPublicController {

    private final WaitingService waitingService;


    /* 웨이팅 리스트 조회(식당) */
    @GetMapping("restaurant/{restaurantSeq}")
    public ResponseEntity<?> getWaitingList(@PathVariable("restaurantSeq") Integer restaurantSeq) {

        return ResponseEntity.ok(waitingService.getWaitingList(restaurantSeq));
    }









}//WaitingPublicController
