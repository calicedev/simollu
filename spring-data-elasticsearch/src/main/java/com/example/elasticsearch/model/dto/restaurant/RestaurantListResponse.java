package com.example.elasticsearch.model.dto.restaurant;
import com.example.elasticsearch.aws.AwsS3Repository;
import com.example.elasticsearch.model.document.RestaurantDocument;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class RestaurantListResponse {
    private Long restaurantSeq;
    private String restaurantName;
    private int restaurantRating;
    private String restaurantImg;
    private String restaurantX;
    private String restaurantY;
    private int restaurantWaitingTime;
    private int restaurantWaitingTeam;
    private Double distance;
    private boolean restaurantLike;
}
