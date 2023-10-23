package com.simollu.UserService.service;


import com.simollu.UserService.dto.user.UserInfoJwtDto;
import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceRequestDto;
import com.simollu.UserService.dto.userpreference.RegisterUserPreferenceResponseDto;
import com.simollu.UserService.dto.userpreference.UserPreferenceResponseDto;
import com.simollu.UserService.entity.UserPreference;
import com.simollu.UserService.jwt.TokenProvider;
import com.simollu.UserService.repository.UserPreferenceRepository;
import com.simollu.UserService.util.PreferenceManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class UserPreferenceService {

    private final UserPreferenceRepository userPreferenceRepository;
    private final TokenProvider tokenProvider;


    private final PreferenceManager preferenceManager;




    // 회원 취향 삽입
    public UserPreferenceResponseDto registerUserPreference(String userSeq,
                                                                    RegisterUserPreferenceRequestDto requestDto) {

        // 기존 회원 취향 삭제
        userPreferenceRepository.deleteAllByUserSeq(userSeq);

        List<UserPreference> userPreferenceList = new ArrayList<>();

        for (String preferenceType : requestDto.getUserPrefernceList()) {
            UserPreference userPreference = UserPreference.builder()
                    .userSeq(userSeq)
                    .userPreferenceType(preferenceType)
                    .build();

            userPreferenceList.add(userPreference);
        }

        // 저장된 취향들을 반환하기 위해 저장
        List<UserPreference> save = userPreferenceRepository.saveAll(userPreferenceList);

        UserPreferenceResponseDto responseDto = getUserPreference(userSeq);

        return responseDto;
    }

    // 회원 취향 조회
    public UserPreferenceResponseDto getUserPreference(String userSeq) {

        List<UserPreference> userPreferences = userPreferenceRepository.findAllByUserSeq(userSeq);
        List<String> responseList = new ArrayList<>();

        Map<String, List<String>> preferenceMap = preferenceManager.getPreferenceMap();

        List<String> preferenceKeyList = new ArrayList<>();

        for(UserPreference prefer : userPreferences) {
            List<String> one = preferenceMap.getOrDefault(prefer.getUserPreferenceType(), Collections.emptyList());

            // 비어있는 경우 생략
            if (one.isEmpty()) {
                continue;
            }

            preferenceKeyList.add(prefer.getUserPreferenceType());

            for (String data : one) {
                responseList.add(data);
            }
        }

        return UserPreferenceResponseDto.builder()
                .userSeq(userSeq)
                .userPrefernceList(preferenceKeyList)
                .userPreferncePlaceList(responseList)
                .build();
    }




}
