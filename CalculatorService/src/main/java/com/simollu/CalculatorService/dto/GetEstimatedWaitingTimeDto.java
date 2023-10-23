package com.simollu.CalculatorService.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetEstimatedWaitingTimeDto {

    Integer restaurantSeq;

    // "2023-05-12" 형식으로 전송
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate targetDate;

    // "13:45" 형식으로 전송
    @DateTimeFormat(iso = DateTimeFormat.ISO.TIME)
    private LocalTime targetTime;



}
