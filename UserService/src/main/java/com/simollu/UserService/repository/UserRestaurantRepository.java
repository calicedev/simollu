package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserRestaurant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRestaurantRepository extends JpaRepository<UserRestaurant, Long> {

    Optional<UserRestaurant> findByUserSeqAndRestaurantSeq(String userSeq, Long restaurantSeq);

    List<UserRestaurant> findByUserSeq(String userSeq);


    // 삭제
    void deleteByUserSeqAndRestaurantSeq(String userSeq, Long restaurantSeq);


}
