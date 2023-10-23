package com.example.elasticsearch.controller;

import com.example.elasticsearch.model.dto.main.RestaurantMainInfoListResponse;
import com.example.elasticsearch.model.dto.main.RestaurantMainInfoResponse;
import com.example.elasticsearch.model.service.RestaurantService;
import java.io.IOException;
import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/main")
public class MainController {

    private final RestaurantService restaurantService;

    // main 거리순 보내기
    @GetMapping("/{lat}/{lon}")
    public ResponseEntity<RestaurantMainInfoListResponse> mainInfoList(
            @RequestHeader("userSeq") String userSeq,
            @PathVariable("lat") Double lat,
            @PathVariable("lon") Double lon) throws IOException {
        return ResponseEntity.ok(restaurantService.getMainInfo(userSeq,lat,lon));
    }




}
