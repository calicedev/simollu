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
public class WaitingRegistDto {


    private int waitingSeq; // 대기 일련번호
    private int waitingNo; // 대기 번호(변하지 않는 대기번호)
    private int waitingTime; // 예상 대기시간


}
