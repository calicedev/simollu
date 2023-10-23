package com.simollu.UserService.dto.user;


import com.simollu.UserService.entity.Authority;
import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class UserInfoJwtDto {

    private String userSeq;
    private List<String> userAuthority;
    private String userNicknameContent;
    private String userProfileUrl;

}
