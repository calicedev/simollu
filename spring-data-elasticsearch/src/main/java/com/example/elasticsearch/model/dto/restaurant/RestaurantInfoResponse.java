package com.example.elasticsearch.model.dto.restaurant;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class RestaurantInfoResponse {
    private Long restaurantSeq;
    private String restaurantName;
    private String restaurantCategory;
    private String restaurantBusinessHours;
    private String restaurantPhoneNumber;
    private String restaurantAddress;
    private String restaurantImg;
    private int restaurantRating;
    private boolean restaurantLike;
    private String restaurantY;
    private String restaurantX;

}
