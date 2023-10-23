package com.simollu.WaitingService.model.dto.review;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WriteableReviewDto {

    private Integer writeableSeq; // 작성가능후기 일련번호

    private String userSeq; // 회원일련번호

    private Integer restaurantSeq; // 식당일련번호

    private LocalDateTime waitingCompleteDate; // 웨이팅완료시간 (입장시간)

    private String restaurantName; // 식당 이름

    private String restaurantImg; // 식당 이미지

}
