package com.example.elasticsearch.controller;


import com.example.elasticsearch.model.dto.review.ModifyReviewDto;
import com.example.elasticsearch.model.dto.review.MyReviewDto;
import com.example.elasticsearch.model.dto.review.RestaurantReviewDto;
import com.example.elasticsearch.model.dto.review.WriteableReviewDto;
import com.example.elasticsearch.model.service.ReviewService;
import com.fasterxml.jackson.core.JsonProcessingException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/review")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {
    private final ReviewService reviewService;

    /* 후기 작성 */
    @PostMapping
    public ResponseEntity<?> writeReview(
            @RequestHeader("userSeq") String userSeq,
            @RequestBody RestaurantReviewDto reviewDto) {
        return ResponseEntity.ok(reviewService.writeReview(userSeq, reviewDto));
    }

    /* 후기 리스트 조회 */
    @GetMapping("{restaurantSeq}")
    public ResponseEntity<?> getReviewList(@PathVariable Long restaurantSeq) {
        return ResponseEntity.ok(reviewService.getReviewList(restaurantSeq));
    }


    /* 후기 상세 조회 */
    @GetMapping("detail/{reviewSeq}")
    public ResponseEntity<?> getReview(@PathVariable Long reviewSeq) {
        return ResponseEntity.ok(reviewService.getReview(reviewSeq));
    }

    /* 후기 수정 */
    @PutMapping("detail")
    public ResponseEntity<?> modifyReview(@RequestBody ModifyReviewDto modifyReviewDto) {
        return ResponseEntity.ok(reviewService.modifyReview(modifyReviewDto));
    }

    @GetMapping
    public ResponseEntity<?> getMyReviewList(@RequestHeader("userSeq") String userSeq) {
        List<MyReviewDto> myReviewDtoList = reviewService.getMyReviewList(userSeq);

        if(myReviewDtoList == null ) return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        return ResponseEntity.ok(myReviewDtoList);
    }

    /* 작성가능 리뷰 리스트 조회 */
    @GetMapping("/writeable")
    public ResponseEntity<?> getWriteableList(@RequestHeader("userSeq") String userSeq) {
        List<WriteableReviewDto> writeableReviewDtoList = reviewService.getWriteableList(userSeq);

        if(writeableReviewDtoList == null) return ResponseEntity.status(202).build();
        return ResponseEntity.ok(writeableReviewDtoList);
    }


    @GetMapping("/writeReviewRedis")
    public void writeReviewRedis() throws JsonProcessingException {
        reviewService.writeReviewRedis();

    }

    /* 작성가능 리뷰 저장 */
    @PostMapping("/writeable")
    public void addWriteableReview(@RequestBody WriteableReviewDto writeableReviewDto) {
        reviewService.addWriteableReview(writeableReviewDto);
    }

}
