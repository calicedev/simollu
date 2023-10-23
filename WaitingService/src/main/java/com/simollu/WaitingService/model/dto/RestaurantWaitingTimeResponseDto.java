package com.simollu.WaitingService.model.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RestaurantWaitingTimeResponseDto {

    // restaurantSeq : <waitingTime, waitingTeam>
    // 식당 일련번호 : <웨이팅 시간>
    HashMap<Long, Integer> waitingTimeMap;
}
