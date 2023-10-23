package com.example.elasticsearch.model.entity;


import com.example.elasticsearch.model.dto.restaurant.RestaurantSaveRequest;
import lombok.*;
import javax.persistence.*;

@Getter
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Restaurant{

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="restaurant_seq")
    private Long restaurantSeq;
    @Column(name="restaurant_name")
    private String restaurantName;
    @Column(name="restaurant_category")
    private String restaurantCategory;
    @Column(name="restaurant_business_hours")
    private String restaurantBusinessHours;
    @Column(name="restaurant_phone_number")
    private String restaurantPhoneNumber;
    @Column(name="restaurant_address")
    private String restaurantAddress;
    @Column(name="restaurant_y")
    private String restaurantY;
    @Column(name="restaurant_x")
    private String restaurantX;
    @Column(name="restaurant_img")
    private String restaurantImg;
    @Column(nullable = true, name="restaurant_rating")
    private int restaurantRating;

    public static Restaurant from (RestaurantSaveRequest restaurantSaveRequest){
        return Restaurant.builder()
                .restaurantName(restaurantSaveRequest.getRestaurantName())
                .restaurantBusinessHours(restaurantSaveRequest.getRestaurantBusinessHours())
                .restaurantCategory(restaurantSaveRequest.getRestaurantCategory())
                .restaurantRating(restaurantSaveRequest.getRestaurantRating())
                .restaurantPhoneNumber(restaurantSaveRequest.getRestaurantPhoneNumber())
                .restaurantAddress(restaurantSaveRequest.getRestaurantAddress())
                .restaurantX(restaurantSaveRequest.getRestaurantX())
                .restaurantY(restaurantSaveRequest.getRestaurantY())
                .restaurantImg(restaurantSaveRequest.getRestaurantImg())
                .build();
    }
}
