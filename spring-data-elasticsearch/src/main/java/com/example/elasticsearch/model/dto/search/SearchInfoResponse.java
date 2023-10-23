package com.example.elasticsearch.model.dto.search;

import com.example.elasticsearch.model.dto.menu.MenuInfoResponse;
import com.example.elasticsearch.model.dto.restaurant.WaitingTimeResponse;
import com.example.elasticsearch.model.dto.review.ReviewInfoResponse;
import com.example.elasticsearch.model.dto.restaurant.RestaurantInfoResponse;
import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class SearchInfoResponse {
    private RestaurantInfoResponse restaurantInfo;
    private List<MenuInfoResponse> menuInfoList;
    private List<WaitingTimeResponse> waitingTimeList;


}
