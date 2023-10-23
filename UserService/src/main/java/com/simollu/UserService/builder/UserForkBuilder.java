package com.simollu.UserService.builder;


import com.simollu.UserService.dto.userfork.UserForkLogListDto;
import com.simollu.UserService.dto.userfork.UserForkPageDto;
import com.simollu.UserService.entity.UserForkLog;
import com.simollu.UserService.util.ConstantUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserForkBuilder {

    private final ConstantUtil constantUtil;


    public UserForkPageDto userForkLogToUserForkPageDto(UserForkLog userForkLog) {

        return UserForkPageDto.builder()
                .userForkAmount(userForkLog.getUserForkAmount())
                .userForkBalance(userForkLog.getUserForkBalance())
                .userForkType(userForkLog.getUserForkType())
                .userForkContent(userForkLog.getUserForkContent())
                .userForkRegisterDate(userForkLog.getUserForkRegisterDate().format(constantUtil.simpleFormatter))
                .build();

    }

    public UserForkLogListDto userForkLogToUserForkListDto(UserForkLog userForkLog) {

        return UserForkLogListDto.builder()
                .userForkDiff(userForkLog.getUserForkAmount())
                .userForkAmount(userForkLog.getUserForkBalance())
                .userForkType(userForkLog.getUserForkType())
                .userForkContent(userForkLog.getUserForkContent())
                .userForkRegisterDate(userForkLog.getUserForkRegisterDate().format(constantUtil.simpleFormatter))
                .build();
    }


}
