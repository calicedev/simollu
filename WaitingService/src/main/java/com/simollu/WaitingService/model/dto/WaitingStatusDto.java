package com.simollu.WaitingService.model.dto;

import com.simollu.WaitingService.model.entity.WaitingStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WaitingStatusDto {

    private Integer waitingSeq; // 대기일련번호

    private int waitingStatusContent; // 대기상태내용 - 0:대기중  / 1:입장완료 / 2:대기취소 / 3:순서미루기

    private int waitingStatusRank; // 대기시점 순서

    private LocalDateTime waitingStatusRegistDate; // 대기상태적용일시

    public WaitingStatus toEntity() {
        return WaitingStatus.builder()
                .waitingSeq(this.waitingSeq)
                .waitingStatusContent(this.waitingStatusContent)
                .waitingStatusRank(this.waitingStatusRank)
                .waitingStatusRegistDate(this.waitingStatusRegistDate)
                .build();
    }

}//WaitingStatusDto
