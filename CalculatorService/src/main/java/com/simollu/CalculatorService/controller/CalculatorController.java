package com.simollu.CalculatorService.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.simollu.CalculatorService.algorithm.DummyAlgorithm;
import com.simollu.CalculatorService.dto.CreateDummyRequestDto;
import com.simollu.CalculatorService.dto.GetEstimatedTimeDto;
import com.simollu.CalculatorService.dto.GetEstimatedWaitingTimeDto;
import com.simollu.CalculatorService.service.WaitingLogService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
@Slf4j
public class CalculatorController {

    private final WaitingLogService waitingLogService;
    private final DummyAlgorithm dummyAlgorithm;

    @PostMapping("createDummy")
    public ResponseEntity<?> createDummy(@RequestBody CreateDummyRequestDto requestDto) {

        dummyAlgorithm.makeDummy(requestDto);

        return ResponseEntity.ok().build();
    }


    @GetMapping("findAverageTime")
    public ResponseEntity<?> findAverageTime() throws JsonProcessingException {
        Map<Long, Map<String, Double>> response = waitingLogService.getAverageWaitingTime();
        return ResponseEntity.ok(response);
    }

    @GetMapping("findRatioTime")
    public ResponseEntity<?> findRatioTime() {
        Map<Long, Map<String, Double>> response = waitingLogService.getAverageWaitingTimePerRank();
        return ResponseEntity.ok(response);
    }



}
