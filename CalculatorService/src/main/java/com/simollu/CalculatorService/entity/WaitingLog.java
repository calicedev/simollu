package com.simollu.CalculatorService.entity;


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
@Table(name = "waiting_log")
public class WaitingLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "waiting_log_seq")
    private Long waitingLogSeq; // 대기로그일련번호

    @NotNull
    @Column(name = "restaurant_seq")
    private Long restaurantSeq; // 식당일련번호

    @NotNull
    @Column(name = "waiting_person_cnt")
    private int waitingPersonCnt; // 대기인원

    @Column(name = "waiting_log_rank")
    private int waitingLogRank; // 대기순위

    @NotNull
    @Column(name = "waiting_log_time")
    private long waitingLogTime; //대기시간

    @Column(name = "waiting_status_regist_date")
    private LocalDateTime waitingStatusRegistDate; // 대기시작시간


    @Column(name = "waiting_status_entrance_date")
    private LocalDateTime waitingStatusEntranceDate; // 입장시간


}
