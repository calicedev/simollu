package com.example.elasticsearch.repository.jpa;

import com.example.elasticsearch.model.entity.Menu;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MenuJpaRepository extends JpaRepository<Menu,Long> {

    List<Menu> findByRestaurantSeq(long restaurantSeq);
}
