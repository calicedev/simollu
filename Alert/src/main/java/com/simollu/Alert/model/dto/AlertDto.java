package com.simollu.Alert.model.dto;

import com.simollu.Alert.model.entity.Alert;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AlertDto {

    private Long alertSeq; // 알림 일련번호

    private String userSeq; // 사용자 일련번호

    private String alertTitle; // 알림 제목

    private String alertContent; // 알림 내용

    private LocalDateTime alertRegistDate; // 알림 생성 날짜

    private boolean alertIsRead; // 읽음 여부

    public AlertDto(Alert alert) {
        this.alertSeq = alert.getAlertSeq();
        this.userSeq = alert.getUserSeq();
        this.alertTitle = alert.getAlertTitle();
        this.alertContent = alert.getAlertContent();
        this.alertRegistDate = alert.getAlertRegistDate();
        this.alertIsRead = alert.isAlertIsRead();
    }

    public Alert toEntity() {
        return Alert.builder()
                .alertSeq(this.alertSeq)
                .userSeq(this.userSeq)
                .alertTitle(this.alertTitle)
                .alertContent(this.alertContent)
                .alertRegistDate(this.alertRegistDate)
                .alertIsRead(this.alertIsRead)
                .build();
    }

}//AlertDto
