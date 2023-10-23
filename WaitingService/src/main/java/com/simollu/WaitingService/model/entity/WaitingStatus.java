package com.simollu.WaitingService.model.entity;

/* 대기 상태 (완료/취소) */

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "waiting_status")
public class WaitingStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer waitingStatusSeq; // 대기상태일련번호

    @NotNull
    @Column(name = "waiting_seq")
    private Integer waitingSeq; // 대기일련번호

    @NotNull
    @Column(name = "waiting_status_content")
    private int waitingStatusContent; // 대기상태내용 - 0:대기중  / 1:입장완료 / 2:대기취소 / 3:순서미루기

    @Column(name = "waiting_status_rank")
    private int waitingStatusRank; // 대기시점 순서

    @Column(name = "waiting_status_regist_date")
    private LocalDateTime waitingStatusRegistDate; // 대기상태적용일시



}//WaitingStatusEntity
