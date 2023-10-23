package com.simollu.Alert.model.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "alert")
public class Alert {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long alertSeq; // 알림 일련번호

    @NotNull
    @Column(name = "user_seq")
    private String userSeq; // 사용자 일련번호

    @NotNull
    @Column(name = "alert_title")
    private String alertTitle; // 알림 제목

    @NotNull
    @Column(name = "alert_content")
    private String alertContent; // 알림 내용

    @NotNull
    @Column(name = "alert_regist_date")
    private LocalDateTime alertRegistDate; // 알림 생성 날짜

    @NotNull
    @Column(name = "alert_is_read")
    private boolean alertIsRead; // 읽음 여부
}//Alert
