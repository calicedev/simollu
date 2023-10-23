package com.simollu.WaitingService.model.dto.alert;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class NotificationRequestDto {
    private String targetUserSeq;
    private String title;
    private String body;
    private String code;

}
