package com.example.elasticsearch.model.dto.main;


import com.example.elasticsearch.model.dto.restaurant.RestaurantHighRatingListResponse;
import com.example.elasticsearch.model.dto.restaurant.RestaurantLessWaitingListResponse;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class RestaurantMainInfoListResponse {
    private List<RestaurantMainInfoResponse> restaurantNearByList;
    private List<RestaurantMainInfoResponse> restaurantHighRatingList;
    private List<RestaurantMainInfoResponse> restaurantLessWaitingList;
    private List<RestaurantMainThemeInfoResponse> koreanFoodTopList;
    private List<RestaurantMainThemeInfoResponse> westernFoodTopList;
    private List<RestaurantMainThemeInfoResponse> chineseTopList;
    private List<RestaurantMainThemeInfoResponse> japanesTopList;
    private List<RestaurantMainThemeInfoResponse> fastFoodTopList;
    private List<RestaurantMainThemeInfoResponse> cafeTopList;
    private List<RestaurantMainThemeInfoResponse> bakeryTopList;
}
