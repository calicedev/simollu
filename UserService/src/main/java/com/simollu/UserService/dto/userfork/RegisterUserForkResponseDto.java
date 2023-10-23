package com.simollu.UserService.dto.userfork;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDateTime;

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
