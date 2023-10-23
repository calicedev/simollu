package com.simollu.UserService.dto.userinfo;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetUserInfoListResponseDto {

    private String userSeq;
    private String userNicknameContent;
    private String userProfileUrl;

}
