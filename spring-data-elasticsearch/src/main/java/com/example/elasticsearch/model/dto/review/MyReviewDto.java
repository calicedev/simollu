package com.example.elasticsearch.model.dto.review;

import com.example.elasticsearch.model.entity.Review;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MyReviewDto {

    private Long reviewSeq; // 후기일련번호
    private String userSeq; // 회원일련번호
    private Long restaurantSeq; // 식당일련번호
    private boolean reviewRating; // 평가 (0:아쉬워요 / 1:기다릴만해요)
    private String reviewContent; // 후기내용 : 글자수 제한 : 100자
    private LocalDateTime reviewRegistDate; // 후기등록일시
    private String restaurantName; // 식당 이름
    private String restaurantImg; // 식당 이미지

    public Review toEntity() {
        return Review.builder()
                .userSeq(userSeq)
                .restaurantSeq(restaurantSeq)
                .reviewRating(reviewRating)
                .reviewContent(reviewContent)
                .reviewRegistDate(reviewRegistDate)
                .build();

    }

    //public MyReviewDto(Integer reviewSeq, String userSeq, Integer restaurantSeq)

}
