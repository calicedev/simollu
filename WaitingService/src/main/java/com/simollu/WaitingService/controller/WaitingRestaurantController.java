package com.simollu.WaitingService.controller;

import com.simollu.WaitingService.model.dto.WaitingCompleteRequestDto;
import com.simollu.WaitingService.model.dto.WaitingHistoryDto;
import com.simollu.WaitingService.model.dto.WaitingStatusDto;
import com.simollu.WaitingService.model.service.WaitingService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/restaurant")
@RequiredArgsConstructor
@Slf4j
@Api(tags = "Waiting API")
public class WaitingRestaurantController {

    private final WaitingService waitingService;

    private static final int STATUS_COMPLETE = 1; // 완료

    /* 웨이팅 리스트 조회(식당) */
    @GetMapping("{restaurantSeq}")
    public ResponseEntity<?> getWaitingList(@PathVariable("restaurantSeq") Integer restaurantSeq) {

        return ResponseEntity.ok(waitingService.getWaitingList(restaurantSeq));
    }

    /* 웨이팅 완료 (식당) */
    @PostMapping("/complete")
    public ResponseEntity<?> updateStatusComplete(@RequestBody WaitingCompleteRequestDto waitingCompleteRequestDto){
        WaitingHistoryDto waitingDto = waitingService.getWaiting(waitingCompleteRequestDto.getUserSeq()).toHistoryDto();
        waitingDto.setWaitingStatusContent(STATUS_COMPLETE);
        WaitingStatusDto waitingStatusDto = WaitingStatusDto.builder()
                .waitingSeq(waitingCompleteRequestDto.getWaitingSeq())
                .waitingStatusContent(STATUS_COMPLETE)
                .build();

        if(waitingService.updateStatus(waitingStatusDto, waitingDto)){
            return ResponseEntity.status(HttpStatus.OK).build();
        }else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }//updateStatus

    /*
     * 웨이팅 입장
     * */
//    @PostMapping("complete")
//    public ResponseEntity<?> updateStatus(@RequestBody WaitingStatusDto waitingStatusDto){
//        WaitingHistoryDto waitingDto = waitingService.getWaiting(waitingStatusDto.getUserSeq()).toHistoryDto();
//
//        // 알림 보내는 로직
//
//        return null;
//    }//updateStatus

}
