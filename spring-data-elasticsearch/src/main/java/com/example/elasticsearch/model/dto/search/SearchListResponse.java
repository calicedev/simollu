package com.example.elasticsearch.model.dto.search;

import lombok.Getter;

@Getter

public class SearchListResponse {
    private Long restaurantSeq;
    private String restaurantName;
    private int restaurantRating;
    private String restaurantX;
    private String restaurantY;
    private String restaurantImg;
    private boolean restaurantLike;
}
