package com.simollu.UserService.dto.restaurant;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class RestaurantFavoriteResponse {
    private Long restaurantSeq;

    private String restaurantName;

    private String restaurantCategory;

    private String restaurantAddress;

    private String restaurantImg;

    private int restaurantRating;

}
