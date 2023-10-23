package com.example.elasticsearch.model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="menu_seq")
    private Long menuSeq;
    @Column(name="restaurant_seq")
    private Long restaurantSeq;
    @Column(name="menu_name")
    private String menuName;
    @Column(name="menu_price")
    private String menuPrice;
    @Column(name="menu_image")
    private String menuImage;
}
