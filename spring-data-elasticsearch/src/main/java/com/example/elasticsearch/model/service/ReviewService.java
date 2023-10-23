package com.example.elasticsearch.model.service;



import com.example.elasticsearch.model.dto.review.*;

import com.fasterxml.jackson.core.JsonProcessingException;
import java.util.List;

public interface ReviewService {

    /* 후기 작성 */
    Long writeReview(String userSeq, RestaurantReviewDto reviewDto);

    /* 후기 리스트 조회 */
    List<RestaurantReviewResponseDto> getReviewList(Long restaurantSeq);

    /* 후기 상세 조회 */
    RestaurantReviewDto getReview(Long reviewSeq);

    /* 후기 수정 */
    RestaurantReviewDto modifyReview(ModifyReviewDto modifyReviewDto);

    /* 내 리뷰 리스트 조회 */
    List<MyReviewDto> getMyReviewList(String userSeq);

    /* 작성가능 리뷰 리스트 조회 */
    List<WriteableReviewDto> getWriteableList(String userSeq);

    /* 작성가능 리뷰 추가 */
    void addWriteableReview(WriteableReviewDto writeableReviewDto);

    void writeReviewRedis() throws JsonProcessingException;

}
