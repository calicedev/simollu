package com.simollu.UserService.dto.userfirebasetoken;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FirebaseTokenRequestDto {

    private String userSeq; // user 시퀀스
    private String fcmToken; // firebase token

}//FirebaseTokenRequestDto
