package com.simollu.UserService.dto.userfork;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserForkPageDto {

    private int userForkAmount;
    private int userForkBalance;
    private String userForkType;
    private String userForkContent;
    private String userForkRegisterDate;



}
