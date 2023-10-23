package com.example.elasticsearch.model.dto.main;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class RestaurantMainThemeInfoResponse {
    private Long restaurantSeq;
    private String restaurantName;
    private String restaurantAddress;
    private Double distance;
    private int restaurantRating;
    private int restaurantWaitingTime;
    private String restaurantImage;
    private boolean restaurantLike;
}
