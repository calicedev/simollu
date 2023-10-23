package com.simollu.UserService.dto.usernickname;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserNicknameResponseDto {

    private String userNicknameContent;

}
