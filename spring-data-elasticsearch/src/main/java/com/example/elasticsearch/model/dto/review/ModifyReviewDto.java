package com.example.elasticsearch.model.dto.review;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ModifyReviewDto {

    private Long reviewSeq; // 후기일련번호
    private boolean reviewRating; // 평가 (0:아쉬워요 / 1:기다릴만해요)
    private String reviewContent; // 후기내용 : 글자수 제한 : 100자

}
