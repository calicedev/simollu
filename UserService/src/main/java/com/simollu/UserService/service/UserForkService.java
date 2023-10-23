package com.simollu.UserService.service;


import com.simollu.UserService.builder.UserForkBuilder;
import com.simollu.UserService.dto.userfork.*;
import com.simollu.UserService.dto.user.UserInfoJwtDto;
import com.simollu.UserService.entity.UserForkLog;
import com.simollu.UserService.jwt.TokenProvider;
import com.simollu.UserService.repository.UserForkLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class UserForkService {


    private final UserForkLogRepository userForkLogRepository;
    private final TokenProvider tokenProvider;
    private final UserForkBuilder userForkBuilder;

    private final int size = 10;


    // 회원 포크 내역 추가
    public RegisterUserForkResponseDto registerUserForkLog(String userSeq, RegisterUserForkRequestDto registerUserForkRequestDto) {

        // 최근 하나의 것을 가져온다.
        UserForkLog latestOne = userForkLogRepository.findTopByUserSeqOrderByUserForkRegisterDateDesc(userSeq);

        // 일단은 들어오는 값이 음수, 양수라고 생각한다.
        int balance = latestOne.getUserForkBalance() + registerUserForkRequestDto.getUserForkAmount();

        // 저장
        UserForkLog userForkLog = UserForkLog.builder()
                .userSeq(userSeq)
                .userForkAmount(registerUserForkRequestDto.getUserForkAmount())
                .userForkBalance(balance)
                .userForkType(registerUserForkRequestDto.getUserForkType())
                .userForkContent(registerUserForkRequestDto.getUserForkContent())
                .build();
        UserForkLog save = userForkLogRepository.save(userForkLog);

        System.out.println(save.toString());

        // 반환
        RegisterUserForkResponseDto responseDto  = RegisterUserForkResponseDto.builder()
                .userForkSeq(save.getUserForkSeq())
                .userSeq(save.getUserSeq())
                .userForkAmount(save.getUserForkAmount())
                .userForkBalance(save.getUserForkBalance())
                .userForkType(save.getUserForkType())
                .userForkContent(save.getUserForkContent())
                .userForkRegisterDate(
                        save.getUserForkRegisterDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                .build();

        return responseDto;
    }

    // 회원 포크 조회
    public UserForkResponseDto getUserFork(String userSeq) {
        // 최근 하나의 것을 가져온다.
        UserForkLog latestOne = userForkLogRepository.findTopByUserSeqOrderByUserForkRegisterDateDesc(userSeq);

        return UserForkResponseDto.builder()
                .userFork(latestOne.getUserForkBalance())
                .build();
    }


    // 회원 포크 내역 리스트 조회
    public List<UserForkLogListDto> getUserForkLogList(String userSeq) {

        List<UserForkLog> userForkLogList = userForkLogRepository.findByUserSeqOrderByUserForkRegisterDateDesc(userSeq);

        return userForkLogList.stream()
                .map(userForkBuilder::userForkLogToUserForkListDto)
                .collect(Collectors.toList());
    }



    // 회원 포크 내역 페이지 조회
    public Page<UserForkPageDto> getUserForkLogPage(String userSeq, int page) {
        PageRequest pageRequest = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "userForkRegisterDate"));
        Page<UserForkLog> userForkPage = userForkLogRepository.findByUserSeqOrderByUserForkRegisterDateDesc(userSeq, pageRequest);

        return userForkPage.map(userForkBuilder::userForkLogToUserForkPageDto);
    }


}
