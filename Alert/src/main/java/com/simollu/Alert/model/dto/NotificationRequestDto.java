package com.simollu.Alert.model.dto;

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
