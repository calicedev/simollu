package com.example.elasticsearch.model.dto.waiting;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RestaurantWaitingStatusRequestDto {

    List<Long> restaurantList;

}
