package com.simollu.WaitingService.model.dto;

import com.simollu.WaitingService.model.entity.Waiting;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WaitingDto {

    private Integer waitingSeq; // 대기일련번호

    private String userSeq; // 회원일련번호

    private Integer restaurantSeq; // 식당일련번호

    private int waitingPersonCnt; // 대기 인원

    private int waitingNo; // 대기 번호(변하지 않는 대기번호)

    private String restaurantName; // 식당이름

    public Waiting toEntity() {
        return Waiting.builder()
                .waitingSeq(this.waitingSeq)
                .userSeq(this.userSeq)
                .restaurantSeq(this.restaurantSeq)
                .waitingPersonCnt(this.waitingPersonCnt)
                .waitingNo(this.waitingNo)
                .restaurantName(this.restaurantName)
                .build();
    }


}//WaitingDto
