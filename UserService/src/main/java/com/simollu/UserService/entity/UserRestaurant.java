package com.simollu.UserService.entity;


import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user_restaurant")
public class UserRestaurant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_restaurant_seq")
    private Long userRestaurantSeq;

    @Column(name = "user_seq")
    private String userSeq;

    @Column(name = "restaurant_seq")
    private Long restaurantSeq;


}
