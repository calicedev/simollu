package com.simollu.WaitingService.model.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RestaurantWaitingStatusResponseDto {


    // restaurantSeq : <waitingTime, waitingTeam>
    // 식당 일련번호 : <웨이팅 시간, 대기 중인 팀>
    HashMap<Long, List<Integer>> waitingTimeAndTeam;


}
