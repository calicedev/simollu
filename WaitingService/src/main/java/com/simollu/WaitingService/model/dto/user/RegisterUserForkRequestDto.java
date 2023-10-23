package com.simollu.WaitingService.model.dto.user;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RegisterUserForkRequestDto {

    private int userForkAmount;
    private String userForkType;
    private String userForkContent;

}
