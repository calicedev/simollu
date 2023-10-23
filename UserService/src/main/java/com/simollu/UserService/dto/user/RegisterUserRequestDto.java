package com.simollu.UserService.dto.user;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RegisterUserRequestDto {

    private String userKakao;
    private String userProfileUrl;
    private String userNicknameContent;



}
