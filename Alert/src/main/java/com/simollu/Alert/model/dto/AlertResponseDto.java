package com.simollu.Alert.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AlertResponseDto {

    private Long alertSeq; // 알림 일련번호

    private String alertTitle; // 알림 제목

    private String alertContent; // 알림 내용

    private LocalDateTime alertRegistDate; // 알림 생성 날짜

    private boolean alertIsRead; // 읽음 여부


}//AlertDto
