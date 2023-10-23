package com.example.elasticsearch.model.dto.main;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class RestaurantMainInfoResponse {
    private Long restaurantSeq;
    private String restaurantName;
    private int restaurantRating;
    private int restaurantWaitingTime;
    private String restaurantImage;
    private boolean restaurantLike;

}
