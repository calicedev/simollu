package com.example.elasticsearch.model.document;

import com.example.elasticsearch.model.entity.Restaurant;
import java.io.IOException;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.elasticsearch.common.geo.GeoPoint;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;


import org.springframework.data.elasticsearch.annotations.GeoPointField;
import org.springframework.data.elasticsearch.annotations.Mapping;
import org.springframework.data.elasticsearch.annotations.Setting;
//elk에 들어가는 로직
@Getter
@Builder
@AllArgsConstructor
@JsonIgnoreProperties("_class")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Document(indexName = "restaurant")
@Mapping(mappingPath = "elastic/restaurant-mapping.json")
@Setting(settingPath = "elastic/restaurant-setting.json")
public class RestaurantDocument {
    @Id
    private Long restaurantSeq;
    private String restaurantName;
    private String restaurantCategory;
    private String restaurantBusinessHours;
    private String restaurantPhoneNumber;
    private String restaurantAddress;
    private String restaurantY;
    private String restaurantX;
    private String restaurantImg;
    private int restaurantRating;
    @GeoPointField
    private GeoPoint location;

    public static RestaurantDocument from(Restaurant restaurant) throws IOException {
        return RestaurantDocument.builder()
                .restaurantSeq(restaurant.getRestaurantSeq())
                .restaurantName(restaurant.getRestaurantName())
                .restaurantBusinessHours(restaurant.getRestaurantBusinessHours())
                .restaurantCategory(restaurant.getRestaurantCategory())
                .restaurantRating(restaurant.getRestaurantRating())
                .restaurantPhoneNumber(restaurant.getRestaurantPhoneNumber())
                .restaurantAddress(restaurant.getRestaurantAddress())
                .restaurantImg(restaurant.getRestaurantImg())
                .restaurantX(restaurant.getRestaurantX())
                .restaurantY(restaurant.getRestaurantY())
                .location(new GeoPoint(Double.valueOf(restaurant.getRestaurantY()), Double.valueOf(restaurant.getRestaurantX())))
                .build();
    }

}
