package com.simollu.UserService.service;


import com.simollu.UserService.client.RestaurantServiceClient;
import com.simollu.UserService.dto.restaurant.RestaurantFavoriteResponse;
import com.simollu.UserService.dto.userRestaurant.RegisterUserRestaurantRequestDto;
import com.simollu.UserService.entity.UserRestaurant;
import com.simollu.UserService.repository.UserRestaurantRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class UserRestaurantService {


    private final UserRestaurantRepository userRestaurantRepository;


    private final RestaurantServiceClient restaurantServiceClient;


    // 관심 식당 등록, 해제
    public String registerUserRestaurant(
            String userSeq,
            RegisterUserRestaurantRequestDto requestDto) {

        Long restaurantSeq = requestDto.getRestaurantSeq();

        // 등록 되어있다는 뜻이니 삭제해줘야함
        if (checkUserRestaurant(userSeq, restaurantSeq)) {
            userRestaurantRepository.deleteByUserSeqAndRestaurantSeq(userSeq, restaurantSeq);
            return "delete";
        }
        // 없는 경우 등록
        else {
            UserRestaurant userRestaurant = UserRestaurant.builder()
                    .userSeq(userSeq)
                    .restaurantSeq(requestDto.getRestaurantSeq())
                    .build();

            UserRestaurant save = userRestaurantRepository.save(userRestaurant);

            return "save";
        }
    }

    // 관심 식당 여부 확인
    public boolean checkUserRestaurant(String userSeq, Long restaurantSeq) {
        Optional<UserRestaurant> userRestaurant = userRestaurantRepository.findByUserSeqAndRestaurantSeq(userSeq, restaurantSeq);
        return userRestaurant.isPresent();
    }


    // 관심 식당 전체 조회
    public List<RestaurantFavoriteResponse> getUserRestaurantList(String userSeq) {
        List<UserRestaurant> userRestaurantList = userRestaurantRepository.findByUserSeq(userSeq);

        // 식당과 연동

        List<RestaurantFavoriteResponse> restaurantList = new ArrayList<>();
        for (UserRestaurant data : userRestaurantList) {
            RestaurantFavoriteResponse restaurant = restaurantServiceClient.getRestaurant(userSeq, data.getRestaurantSeq());
            restaurantList.add(restaurant);
        }

        return restaurantList;

    }







}
