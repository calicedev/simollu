package com.simollu.UserService.client;


import com.simollu.UserService.dto.restaurant.RestaurantFavoriteResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(name = "restaurant-service")
public interface RestaurantServiceClient {

    @GetMapping("favorite/{restaurantSeq}")
    RestaurantFavoriteResponse getRestaurant(
            @RequestHeader("userSeq") String userSeq,
            @PathVariable("restaurantSeq") Long restaurantSeq);

}
