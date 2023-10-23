package com.simollu.Alert.model.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AlertReadRequestDto {
    private Long startSeq; // 알림 읽음 처리 시작 시퀀스
    private Long endSeq; // 끝 시퀀스
}
