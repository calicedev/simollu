package com.simollu.WaitingService.controller;

import com.simollu.WaitingService.model.dto.*;
import com.simollu.WaitingService.model.service.WaitingService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
@Api(tags = "Waiting API")
public class WaitingUserController {

    private final WaitingService waitingService;

    private static final int STATUS_COMPLETE = 1; // 완료
    private static final int STATUS_CANCEL = 2; // 취소

    /*
     * 웨이팅 등록
     * */
    @PostMapping
    public ResponseEntity<?> registWaiting(@RequestHeader("userSeq") String userSeq
            , @RequestBody WaitingHistoryDto waitingHistoryDto) {
        waitingHistoryDto.setUserSeq(userSeq);
        if(waitingService.isWaiting(userSeq)) {
            WaitingRegistDto waitingRegistDto = WaitingRegistDto.builder()
                                                .waitingSeq(-1)
                                                .build();
            return ResponseEntity.ok().body(waitingRegistDto);
        }
        WaitingDetailDto waitingDetailDto = waitingService.registWaiting(waitingHistoryDto);
        WaitingRegistDto waitingRegistDto = new WaitingRegistDto(waitingDetailDto.getWaitingSeq() ,waitingDetailDto.getWaitingNo(), waitingDetailDto.getWaitingTime());

        return ResponseEntity.ok().body(waitingRegistDto);
    }//registWaiting

    /*
     * 웨이팅 취소
     * */
    @PostMapping("/cancel")
    public ResponseEntity<?> updateStatusCancel(@RequestHeader("userSeq") String userSeq
                                                , @RequestBody WaitingStatusDto waitingStatusDto){
        WaitingHistoryDto waitingDto = waitingService.getWaiting(userSeq).toHistoryDto();
        waitingDto.setWaitingStatusContent(STATUS_CANCEL);
        waitingStatusDto.setWaitingStatusContent(STATUS_CANCEL);

        if(waitingService.updateStatus(waitingStatusDto, waitingDto)){
            return ResponseEntity.status(HttpStatus.OK).build();
        }else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }//updateStatus

    /*
     * 웨이팅 완료
     * 동언 - waitinglog에 insert 처야함
     * */
    @PostMapping("/complete")
    public ResponseEntity<?> updateStatusComplete(@RequestHeader("userSeq") String userSeq
                                                , @RequestBody WaitingStatusDto waitingStatusDto){
        WaitingHistoryDto waitingDto = waitingService.getWaiting(userSeq).toHistoryDto();
        waitingDto.setWaitingStatusContent(STATUS_COMPLETE);
        waitingStatusDto.setWaitingStatusContent(STATUS_COMPLETE);

        if(waitingService.updateStatus(waitingStatusDto, waitingDto)){
            return ResponseEntity.status(HttpStatus.OK).build();
        }else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }//updateStatus

    /*
     * 회원의 웨이팅 리스트조회
     *
    @GetMapping
    public ResponseEntity<?> getUserWaitingList() {
        return null;
    }//getWaitingList
    */

    /*
     * 웨이팅 상세정보 조회
     * */
    @GetMapping("{waitingSeq}")
    public ResponseEntity<?> getWaitingInfo(@RequestHeader("userSeq") String userSeq
                                            , @PathVariable("waitingSeq") Integer waitingSeq) {
        WaitingDetailDto waitingDetailDto = waitingService.getWaiting(userSeq);
        if(waitingDetailDto == null) return ResponseEntity.noContent().build();
        return ResponseEntity.ok(waitingDetailDto);
    }//getWaitingInfo

    /*
     * 웨이팅 순서변경
     * */
    @PutMapping
    public ResponseEntity<?> changeWaiting(@RequestHeader("userSeq") String userSeq, @RequestBody WaitingDto waitingDto) {
        waitingDto.setUserSeq(userSeq);
        WaitingDetailDto detailDto = waitingService.changeWaiting(waitingDto);
        if(detailDto.getWaitingSeq() == -1) return ResponseEntity.status(202).build();
        return ResponseEntity.ok(detailDto);
    }//changeWaiting

    /* 웨이팅 예상시간 조회 */
    @GetMapping("{restaurantSeq}/{waitingSeq}")
    public ResponseEntity<?> getWaitingTime(
            @PathVariable("restaurantSeq")Integer restaurantSeq
            , @PathVariable("waitingSeq")Integer waitingSeq) {

        return ResponseEntity.ok(waitingService.getWaitingTime(restaurantSeq, waitingSeq));
    }

    /* 웨이팅 내역 조회 (취소/완료) */
    @GetMapping("status/{waitingStatusContent}")
    public ResponseEntity<?> getWaitingHistory(
            @RequestHeader("userSeq") String userSeq, @PathVariable("waitingStatusContent")int waitingStatusContent) {
        List<WaitingHistoryDto> waitingHistory = waitingService.getWaitingHistory(userSeq, waitingStatusContent);
        if (waitingHistory == null) {
            return ResponseEntity.status(204).build();
        }
        return ResponseEntity.ok(waitingHistory);
    }




    /* 식당 리스트 웨이팅 상태 조회(예상 대기 시간, 대기 팀 수 ) */
    @PostMapping("restaurant-list-status")
    public ResponseEntity<?> getRestaurantWaitingStatus(@RequestBody RestaurantWaitingStatusRequestDto requestDto)  {
        RestaurantWaitingStatusResponseDto responseDto = waitingService.getRestaurantWaitingStatus(requestDto);
        return ResponseEntity.ok(responseDto);
    }


    /* 식당 리스트 웨이팅 시간 조회 */
    @PostMapping("restaurant-list-time")
    public ResponseEntity<?> getRestaurantWaitingTime(@RequestBody RestaurantWaitingStatusRequestDto requestDto)  {
        RestaurantWaitingTimeResponseDto responseDto = waitingService.getRestaurantWaitingTime(requestDto);
        return ResponseEntity.ok(responseDto);
    }






    // ---------------------------------------
    /* 식당 seq 웨이팅 시간 조회 */
    @GetMapping("restaurant-status/{restaurantSeq}")
    public ResponseEntity<?> getRestaurantWaitingStatus(@PathVariable("restaurantSeq") Long restaurantSeq)  {
        WaitingOneResponseDto responseDto = waitingService.getOneRestaurantWaitingStatus(restaurantSeq);
        return ResponseEntity.ok(responseDto);
    }




}//WaitingUserController
