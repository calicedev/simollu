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
public class UserPreferenceResponseDto {

    private String userSeq;
    private List<String> userPrefernceList;
    private List<String> userPreferncePlaceList;

}
