package com.simollu.WaitingService.model.dto;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.IOException;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WaitingDetailDto {

    private Integer waitingSeq; // 대기일련번호

    private String userSeq; // 회원일련번호

    private Integer restaurantSeq; // 식당일련번호

    private int waitingPersonCnt; // 대기 인원

    private int waitingNo; // 대기 번호(변하지 않는 대기번호)

    private int waitingTime; // 예상 대기시간

    private int waitingCurRank; // 현재 순서

    private String restaurantName; // 식당이름

    private LocalDateTime waitingStatusRegistDate; // 대기상태적용일시

    private int waitingStatusContent; // 대기상태내용 - 0:대기중  / 1:입장완료 / 2:대기취소 / 3:순서미루기

    public static WaitingDetailDto of(WaitingHistoryDto dto) {
        return WaitingDetailDto.builder()
                .waitingSeq(dto.getWaitingSeq())
                .userSeq(dto.getUserSeq())
                .restaurantSeq(dto.getRestaurantSeq())
                .waitingNo(dto.getWaitingNo())
                .waitingStatusRegistDate(dto.getWaitingStatusRegistDate())
                .restaurantName(dto.getRestaurantName())
                .waitingStatusContent(dto.getWaitingStatusContent())
                .build();
    }

    public WaitingHistoryDto toHistoryDto(){
        return WaitingHistoryDto.builder()
                .waitingSeq(this.waitingSeq)
                .userSeq(this.userSeq)
                .restaurantSeq(this.restaurantSeq)
                .waitingPersonCnt(this.waitingPersonCnt)
                .restaurantName(this.restaurantName)
                .waitingStatusRegistDate(this.waitingStatusRegistDate)
                .waitingStatusContent(this.waitingStatusContent)
                .build();
    }

    public static WaitingDetailDto JsonToDto(String jsonWaiting) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        if(jsonWaiting == null) return null;
        return mapper.readValue(jsonWaiting, WaitingDetailDto.class);
    }

}
