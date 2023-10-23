package com.example.elasticsearch.repository.jpa;

import com.example.elasticsearch.model.entity.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RestaurantJpaRepository extends JpaRepository<Restaurant,Long> {


    Restaurant findByRestaurantSeq(long restaurantSeq);
    List<Restaurant> findAll();
}
