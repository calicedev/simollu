package com.simollu.UserService.service;


import com.simollu.UserService.dto.user.UserInfoJwtDto;
import com.simollu.UserService.dto.usernickname.RegisterUserNicknameRequestDto;
import com.simollu.UserService.dto.usernickname.RegisterUserNicknameResponseDto;
import com.simollu.UserService.dto.usernickname.UserNicknameResponseDto;
import com.simollu.UserService.entity.UserNickname;
import com.simollu.UserService.jwt.TokenProvider;
import com.simollu.UserService.repository.UserNicknameRepository;
import com.simollu.UserService.util.ConstantUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.format.DateTimeFormatter;

@Service
@Transactional
@RequiredArgsConstructor
public class UserNicknameService {

    private final UserNicknameRepository userNicknameRepository;
    private final TokenProvider tokenProvider;
    private final ConstantUtil constantUtil;

    // 유저 닉네임 변경
    public RegisterUserNicknameResponseDto registerUserNickname(
            String userSeq,
            RegisterUserNicknameRequestDto requestDto) {

        // 유저 닉네임 저장
        UserNickname userNickname = UserNickname.builder()
                .userSeq(userSeq)
                .userNicknameContent(requestDto.getUserNicknameContent())
                .build();
        UserNickname save = userNicknameRepository.save(userNickname);

        return RegisterUserNicknameResponseDto.builder()
                .userNicknameSeq(save.getUserNicknameSeq())
                .userSeq(save.getUserSeq())
                .userNicknameContent(save.getUserNicknameContent())
                .userNicknameRegisterDate(save.getUserNicknameRegisterDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                .build();
    }

    // 유저 닉네임 조회
    public UserNicknameResponseDto getUserNickname(String userSeq) {
        UserNickname userNickname = userNicknameRepository.findTopByUserSeqOrderByUserNicknameRegisterDateDesc(userSeq);

        return UserNicknameResponseDto.builder()
                .userNicknameContent(userNickname.getUserNicknameContent())
                .build();
    }







}
