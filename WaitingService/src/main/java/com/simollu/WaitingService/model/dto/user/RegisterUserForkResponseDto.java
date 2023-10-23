package com.simollu.WaitingService.model.dto.user;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RegisterUserForkResponseDto {

    private long userForkSeq;
    private String userSeq;
    private int userForkAmount;
    private int userForkBalance;
    private String userForkType;
    private String userForkContent;
    private String userForkRegisterDate;


}
