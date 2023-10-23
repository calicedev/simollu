package com.example.elasticsearch.model.service;


import com.example.elasticsearch.client.UserServiceClient;
import com.example.elasticsearch.model.dto.review.*;
import com.example.elasticsearch.model.dto.user.GetUserInfoListRequestDto;
import com.example.elasticsearch.model.dto.user.GetUserInfoListResponseDto;
import com.example.elasticsearch.model.dto.user.RegisterUserForkRequestDto;
import com.example.elasticsearch.model.entity.Review;
import com.example.elasticsearch.repository.jpa.RestaurantJpaRepository;
import com.example.elasticsearch.repository.review.ReviewRepository;
import com.example.elasticsearch.repository.review.WriteableReviewRepository;
import com.example.elasticsearch.utils.DateTimeUtils;

import feign.FeignException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.HashMap;
import java.util.Map;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReviewServiceImpl implements ReviewService {
    private final ReviewRepository reviewRepository;
    private final RestaurantJpaRepository restaurantRepository;
    private final RedisTemplate redisTemplate;
    private final ObjectMapper objectMapper;

    private final WriteableReviewRepository writeableReviewRepository;

    private final UserServiceClient userServiceClient;





    /* 후기 작성 */
    @Override
    public Long writeReview(String userSeq, RestaurantReviewDto reviewDto) {

        System.out.println(reviewDto.isReviewRating());

        if(reviewDto.isReviewRating()){
            Integer value = (Integer) redisTemplate.opsForHash().get("review", reviewDto.getRestaurantSeq() + "_true");
        redisTemplate.opsForHash().put("review", reviewDto.getRestaurantSeq() + "_true",value+1);
        }
        Integer value = (Integer) redisTemplate.opsForHash().get("review", reviewDto.getRestaurantSeq() + "_false");
        redisTemplate.opsForHash().put("review", reviewDto.getRestaurantSeq() + "_false",value+1);


        Review review = Review.builder()
                .userSeq(userSeq)
                .restaurantSeq(reviewDto.getRestaurantSeq())
                .reviewRating(reviewDto.isReviewRating())
                .reviewContent(reviewDto.getReviewContent())
                .reviewRegistDate(DateTimeUtils.nowFromZone()) // 현재 시간으로 설정
                .build();

        Long reviewSeq = reviewRepository.save(review).getReviewSeq();

        // 작성가능리뷰 삭제
        writeableReviewRepository.deleteById(reviewDto.getWriteableSeq());

        // 포크 1개 적립
        RegisterUserForkRequestDto request = RegisterUserForkRequestDto.builder()
                .userForkAmount(1)
                .userForkType("적립")
                .userForkContent("리뷰 작성")
                .build();

        userServiceClient.registerUserFork(userSeq, request);

        return reviewSeq;
    }

    /* 후기 리스트 조회 */

    public List<RestaurantReviewResponseDto> getReviewList(Long restaurantSeq) {
        List<Review> reviewList = reviewRepository.findByRestaurantSeq(restaurantSeq);
        List<RestaurantReviewResponseDto> reviewDtoList = new ArrayList<>();
        List<String> userSeqList = new ArrayList<>();

        // 식당 후기 리스트
        for(Review review : reviewList){
            RestaurantReviewResponseDto dto = RestaurantReviewResponseDto.builder()
                    .reviewSeq(review.getReviewSeq())
                    .userSeq(review.getUserSeq())
                    .restaurantSeq(review.getRestaurantSeq())
                    .reviewContent(review.getReviewContent())
                    .reviewRating(review.isReviewRating())
                    .reviewRegistDate(review.getReviewRegistDate())
                    .build();
            reviewDtoList.add(dto);

            //userSeqList.add("9b5be44a-3ddf-4d09-9479-0aea43da907f");
            userSeqList.add(review.getUserSeq());
        }

        // 사용자 정보 리스트
        GetUserInfoListRequestDto requestDto = new GetUserInfoListRequestDto(userSeqList);
        List<GetUserInfoListResponseDto> userInfoList = new ArrayList<>();
        try {
            userInfoList = userServiceClient.getUserInfoList(requestDto);
//            System.out.println("받아와 지니?");
            for(GetUserInfoListResponseDto key : userInfoList) {
                //System.out.println(key.getUserNicknameContent());
                if(key.getUserNicknameContent() == null) key.setUserNicknameContent("닉네임");
                if(key.getUserProfileUrl() == null) key.setEmptyProfileUrl();

            }

        }catch (FeignException e) {
            log.error("userInfo error : {}", e.getMessage());
        }


        // 합치기
        RestaurantReviewResponseDto dto;
        GetUserInfoListResponseDto userInfo;
        for(int i=0, size=reviewDtoList.size(); i<size; i++){
            dto = reviewDtoList.get(i);
            userInfo = userInfoList.get(i);
            dto.setUserNickName(userInfo.getUserNicknameContent());
            dto.setUserImg(userInfo.getUserProfileUrl());
        }

        return reviewDtoList;
    }

    /* 후기 상세 조회 */

    public RestaurantReviewDto getReview(Long reviewSeq) {
        Review review = reviewRepository.findById(reviewSeq).orElse(null);

        return RestaurantReviewDto.builder()
                .reviewSeq(review.getReviewSeq())
                .userSeq(review.getUserSeq())
                .restaurantSeq(review.getRestaurantSeq())
                .reviewContent(review.getReviewContent())
                .reviewRating(review.isReviewRating())
                .reviewRegistDate(review.getReviewRegistDate())
                .build();
    }

    /* 후기 수정 */
    @Override
    public RestaurantReviewDto modifyReview(ModifyReviewDto modifyReviewDto) {
        Review review = reviewRepository.findById(modifyReviewDto.getReviewSeq()).orElse(null);
        review.setReviewRating(modifyReviewDto.isReviewRating());
        review.setReviewContent(modifyReviewDto.getReviewContent());
        reviewRepository.save(review);

        RestaurantReviewDto reviewDto = new RestaurantReviewDto();
        return reviewDto.builder()
                .reviewSeq(modifyReviewDto.getReviewSeq())
                .userSeq(review.getUserSeq())
                .restaurantSeq(review.getRestaurantSeq())
                .reviewRating(review.isReviewRating())
                .reviewContent(review.getReviewContent())
                .reviewRegistDate(review.getReviewRegistDate())
                .build();
    }

    /* 내 리뷰 리스트 조회 */
    @Override
    public List<MyReviewDto> getMyReviewList(String userSeq) {
        List<MyReviewDto> myReviewDtoList = reviewRepository.getReviewByUserSeq(userSeq).orElse(null);
        return myReviewDtoList;
    }

    /* 작성가능 리뷰 리스트 조회 */
    @Override
    public List<WriteableReviewDto> getWriteableList(String userSeq) {
        List<WriteableReviewDto> writeableReviewDtoList = reviewRepository.getWriteableList(userSeq).orElse(null);

        return writeableReviewDtoList;
    }

    /* 작성가능 리뷰 추가 */
    @Override
    public void addWriteableReview(WriteableReviewDto writeableReviewDto) {
        writeableReviewRepository.save(writeableReviewDto.toEntity());
    }
    
    /* review redis 제일 처음 초기화 */
    @Override
    public void writeReviewRedis()  {
        int n = (int) restaurantRepository.count();
        HashOperations<String, Object, Object> hashOps = redisTemplate.opsForHash();
        Map<Object, Object> map = new HashMap<>();
        for(int i=1; i<=n; i++) {
            hashOps.put("review", i+"_false", 0);
            hashOps.put("review", i+"_true", 0);
        }
    }

}
