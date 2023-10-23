package com.example.elasticsearch.model.dto.search;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SearchCondition {

    private Long restaurantSeq;
    private String restaurantName;
    private String restaurantBusinessHours;
    private String restaurantCategory;
    private String restaurantRating;
    private String restaurantPhoneNumber;
    private String restaurantAddress;
    private String restaurantX;
    private String restaurantY;
    private String restaurantImg;
    private boolean restaurantLike;

}
