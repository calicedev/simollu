package com.simollu.WaitingService.model.dto;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.simollu.WaitingService.model.entity.Waiting;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.IOException;
import java.time.LocalDateTime;
/*
* 웨이팅 기록 dto
* */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WaitingHistoryDto {

    private Integer waitingSeq; // 대기일련번호

    private String userSeq; // 회원일련번호

    private Integer restaurantSeq; // 식당일련번호

    private int waitingPersonCnt; // 대기 인원

    private int waitingNo; // 대기 번호(변하지 않는 대기번호)

    private String restaurantName; // 식당이름

    private LocalDateTime waitingStatusRegistDate; // 대기상태적용일시

    private int waitingStatusContent; // 대기상태내용 - 0:대기중  / 1:입장완료 / 2:대기취소 / 3:순서미루기

    public WaitingHistoryDto(Integer waitingSeq, String userSeq, Integer restaurantSeq
            , int waitingNo, String restaurantName, LocalDateTime waitingStatusRegistDate
            , int waitingStatusContent, int waitingPersonCnt) {
        this.waitingSeq = waitingSeq;
        this.userSeq = userSeq;
        this.restaurantSeq = restaurantSeq;
        this.waitingNo = waitingNo;
        this.restaurantName = restaurantName;
        this.waitingStatusRegistDate = waitingStatusRegistDate;
        this.waitingStatusContent = waitingStatusContent;
        this.waitingPersonCnt = waitingPersonCnt;
    }


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

    public static WaitingHistoryDto JsonToDto(String jsonWaiting) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        return mapper.readValue(jsonWaiting, WaitingHistoryDto.class);
    }

    public WaitingDetailDto toWaitingDetailDto() {
        return WaitingDetailDto.builder()
                .waitingSeq(this.waitingSeq)
                .userSeq(this.userSeq)
                .restaurantSeq(this.restaurantSeq)
                .waitingPersonCnt(this.waitingPersonCnt)
                .waitingNo(this.waitingNo)
                .restaurantName(this.restaurantName)
                .waitingStatusRegistDate(this.waitingStatusRegistDate)
                .build();
    }

}
