package com.simollu.UserService.dto.userpreference;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RegisterUserPreferenceRequestDto {

    private List<String> userPrefernceList;

}
