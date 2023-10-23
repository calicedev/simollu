package com.example.elasticsearch.model.entity;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
@Table(name = "review")
@Builder
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reviewSeq; // 후기일련번호

    @NotNull
    @Column(name = "user_seq")
    private String userSeq; // 회원일련번호

    @NotNull
    @Column(name = "restaurant_seq")
    private Long restaurantSeq; // 식당일련번호

    @NotNull
    @Column(name = "review_rating")
    private boolean reviewRating; // 평가 (0:아쉬워요 / 1:기다릴만해요)

    @NotNull
    @Column(name = "review_content", length = 100)
    private String reviewContent; // 후기내용 : 글자수 제한 : 100자


    @Column(name = "review_regist_date")
    private LocalDateTime reviewRegistDate; // 후기등록일시

}
