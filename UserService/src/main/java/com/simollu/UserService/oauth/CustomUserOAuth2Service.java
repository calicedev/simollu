package com.simollu.UserService.oauth;


import com.simollu.UserService.dto.user.RegisterUserRequestDto;
import com.simollu.UserService.entity.User;
import com.simollu.UserService.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomUserOAuth2Service extends DefaultOAuth2UserService {





    private static final Logger logger = LoggerFactory.getLogger(CustomUserOAuth2Service.class);

    private final UserService userService;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);
        return processOAuth2User(userRequest, oAuth2User);
    }


    private OAuth2User processOAuth2User(OAuth2UserRequest userRequest, OAuth2User oAuth2User) {

        // Attribute를 파싱해서 공통 객체로 묶는다. 관리가 편함.
        OAuth2UserInfo oAuth2UserInfo = null;

        // kakao naver 구분 하기 위한 provider 변수
        String provider = userRequest.getClientRegistration().getRegistrationId();

        if (provider.equals("kakao")) {
            logger.info("CustomUserOAuth2Service : 카카오톡 로그인 요청");
            oAuth2UserInfo = new KakaoUserInfo((Map) oAuth2User.getAttributes());
        }

        User user;
        boolean initial = false;

        log.info("CustomUserOAuth2Service - kakao login : {}", oAuth2UserInfo.getProviderId());

        // 가입 여부 확인 - 있음
        if (userService.checkByKakao(oAuth2UserInfo.getProviderId())) {
            user = userService.findByUserKakaoWithAuthorities(oAuth2UserInfo.getProviderId());
            logger.info("CustomUserOAuth2Service - 가입 한적 있음");
        // 가입 여부 확인 - 없음
        } else {
            initial = true;
            RegisterUserRequestDto registerUserRequestDto = RegisterUserRequestDto.builder()
                    .userKakao(oAuth2UserInfo.getProviderId())
                    .userProfileUrl(oAuth2UserInfo.getProfileImage())
                    .userNicknameContent(oAuth2UserInfo.getNickname())
                    .build();

            user = userService.registerUser(registerUserRequestDto);
        }
        logger.info("CustomUserOAuth2Service - 성공");
        logger.info("CustomUserOAuth2Service - oAuth2User , {}", oAuth2User.getAttributes());


        return new PrincipalDetails(user, oAuth2User.getAttributes(), initial);
    }




}
