package com.example.elasticsearch.model.dto.review;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class ReviewInfoResponse {
    private String userNickname;
    private String userProfileUrl;
    private String reviewContent;
    private  boolean reviewRating;
}
