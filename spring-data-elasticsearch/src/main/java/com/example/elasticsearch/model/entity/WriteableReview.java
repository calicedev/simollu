package com.example.elasticsearch.model.entity;

import com.sun.istack.NotNull;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Table(name = "writeable_review")
@Builder
public class WriteableReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long writeableSeq; // 작성가능후기 일련번호

    @NotNull
    @Column(name = "user_seq")
    private String userSeq; // 회원일련번호

    @NotNull
    @Column(name = "restaurant_seq")
    private Long restaurantSeq; // 식당일련번호

    @NotNull
    @Column(name = "waiting_complete_date")
    private LocalDateTime waitingCompleteDate; // 입장완료일시


}
