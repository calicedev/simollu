package com.simollu.UserService.service;

import com.simollu.UserService.dto.user.UserInfoJwtDto;
import com.simollu.UserService.dto.userstatus.RegisterUserStatusRequestDto;
import com.simollu.UserService.dto.userstatus.RegisterUserStatusResponseDto;
import com.simollu.UserService.dto.userstatus.UserStatusResponseDto;
import com.simollu.UserService.entity.UserStatus;
import com.simollu.UserService.jwt.TokenProvider;
import com.simollu.UserService.repository.UserStatusRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.format.DateTimeFormatter;

@Service
@Transactional
@RequiredArgsConstructor
public class UserStatusService {

    private final UserStatusRepository userStatusRepository;
    private final TokenProvider tokenProvider;


    // 회원 상태 변경
    public RegisterUserStatusResponseDto registerUserStatus(String userSeq, RegisterUserStatusRequestDto requestDto) {

        UserStatus userStatus = UserStatus.builder()
                .userSeq(userSeq)
                .userStatusContent(requestDto.getUserStatusContent())
                .build();
        UserStatus save = userStatusRepository.save(userStatus);

        return RegisterUserStatusResponseDto.builder()
                .userStatusSeq(save.getUserStatusSeq())
                .userSeq(save.getUserSeq())
                .userStatusContent(save.getUserStatusContent())
                .userStatusDate(save.getUserStatusDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                .build();
    }

    // 회원 최신 조회
    public UserStatusResponseDto getUserStatus(String userSeq) {

        UserStatus userStatus = userStatusRepository.findTopByUserSeqOrderByUserStatusDateDesc(userSeq);

        return UserStatusResponseDto.builder()
                .userStatusContent(userStatus.getUserStatusContent())
                .build();
    }

}
