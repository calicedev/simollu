package com.simollu.UserService.dto.userRestaurant;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterUserRestaurantResponseDto {

    String userSeq;
    Long restaurantSeq;

}
