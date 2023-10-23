package com.simollu.WaitingService.model.service;

import com.simollu.WaitingService.model.dto.*;

import java.util.List;

public interface WaitingService {

    /* 웨이팅 신청 */
    WaitingDetailDto registWaiting(WaitingHistoryDto waitingDetailDto);

    /* 마지막 웨이팅 번호 가져오기 */
    Integer getLastWaitingNo(Integer restaurantSeq);

    /* 웨이팅 상태 변경 */
    boolean updateStatus(WaitingStatusDto waitingStatusDto, WaitingHistoryDto waitingHistoryDto);

    /* 웨이팅 상세정보 조회 */
//    WaitingDetailDto getWaiting(Integer waitingSeq);
    WaitingDetailDto getWaiting(String userSeq);

    /* 순서 미루기 */
    WaitingDetailDto changeWaiting(WaitingDto waitingDto);

    /* 웨이팅 리스트 조회(식당) */
    List<WaitingHistoryDto> getWaitingList(Integer restaurantSeq);

    /* 웨이팅 예상시간 조회 */
    Integer getWaitingTime(Integer restaurantSeq, Integer waitingSeq);

    /* 웨이팅 예상시간 조회 */
    Integer getWaitingTime(Integer restaurantSeq);

    /* 웨이팅 내역 조회 (취소/완료) */
    List<WaitingHistoryDto> getWaitingHistory(String userSeq, int waitingStatusContent);



    /* 식당 리스트를 받으면 식당 별 대기팀과 웨이팅 시간 반환  */
    RestaurantWaitingStatusResponseDto getRestaurantWaitingStatus(RestaurantWaitingStatusRequestDto requestDto);

    /* 식당 리스트를 받으면 식당 별 웨이팅 시간 반환 */
    RestaurantWaitingTimeResponseDto getRestaurantWaitingTime(RestaurantWaitingStatusRequestDto requestDto);



    public WaitingOneResponseDto getOneRestaurantWaitingStatus(Long restaurantSeq);

    /* 현재 웨이팅 여부 확인 */
    boolean isWaiting(String userSeq);

}//WaitingService
