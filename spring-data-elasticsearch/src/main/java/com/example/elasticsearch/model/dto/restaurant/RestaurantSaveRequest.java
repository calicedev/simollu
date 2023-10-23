package com.example.elasticsearch.model.dto.restaurant;

import lombok.Getter;

@Getter
public class RestaurantSaveRequest {
    private String restaurantName;
    private String restaurantBusinessHours;
    private String restaurantCategory;
    private int restaurantRating;
    private String restaurantPhoneNumber;
    private String restaurantAddress;
    private String restaurantX;
    private String restaurantY;
    private String restaurantImg;
    private boolean restaurantLike;
}
