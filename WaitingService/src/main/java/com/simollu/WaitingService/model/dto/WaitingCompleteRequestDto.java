package com.simollu.WaitingService.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WaitingCompleteRequestDto {

    private Integer waitingSeq; // 대기일련번호

    private String userSeq; // 회원일련번호

    public WaitingStatusDto toWaitingStatusDto() {
        return WaitingStatusDto.builder()
                .waitingSeq(waitingSeq)
                .build();
    }

}
