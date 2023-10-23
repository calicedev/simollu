package com.simollu.Alert.controller;

import com.simollu.Alert.model.dto.AlertDto;
import com.simollu.Alert.model.dto.AlertReadRequestDto;
import com.simollu.Alert.model.dto.AlertSeqDto;
import com.simollu.Alert.model.dto.NotificationRequestDto;
import com.simollu.Alert.service.AlertService;
import com.simollu.Alert.service.FcmNotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping
public class AlertController {

    private final FcmNotificationService fcmNotificationService;
    private final AlertService alertService;

    /* 알림 생성 */
    @PostMapping("alert")
    public ResponseEntity<?> sendNotificationByToken(
            @RequestBody NotificationRequestDto requestDto) {

        return ResponseEntity.
                status(fcmNotificationService.sendNotificationByToken(requestDto))
                .build();
    }

    /* 알림 리스트 조회 */
    @GetMapping("user/alert")
    public ResponseEntity<?> getAlertList(@RequestHeader("userSeq") String userSeq) {
        List<AlertDto> alertDtoList = alertService.getAlertList(userSeq);
        if(alertDtoList == null) return ResponseEntity.status(204).build();
        return ResponseEntity.ok(alertDtoList);
    }

    /* 알림 조회 */
    @GetMapping("user/alert/{alertSeq}")
    public ResponseEntity<?> getAlertDetail(@PathVariable("alertSeq") Long alertSeq) {
        AlertDto alertDto = alertService.getAlertDetail(alertSeq);
        if(alertDto == null) return ResponseEntity.status(204).build();
        return ResponseEntity.ok(alertDto);
    }

    /* 알림 읽음 처리 */
    @PutMapping("user/alert")
    public ResponseEntity<?> readAlertList(@RequestBody AlertReadRequestDto readRequestDto) {
        if(alertService.readAlertList(readRequestDto)) return ResponseEntity.ok().build();
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    }

    /* 알림 삭제 */
    @DeleteMapping("user/alert")
    public ResponseEntity<?> deleteAlertList(@RequestBody List<AlertSeqDto> seqDtoList) {
        if(alertService.deleteAlertList(seqDtoList)) return ResponseEntity.ok().build();
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    }

}
