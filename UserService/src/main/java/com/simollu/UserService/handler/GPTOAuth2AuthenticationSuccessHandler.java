package com.simollu.UserService.handler;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.simollu.UserService.jwt.TokenProvider;
import com.simollu.UserService.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;

@Component
@RequiredArgsConstructor
public class GPTOAuth2AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {


    @Autowired
    private ObjectMapper objectMapper;
    private final TokenProvider tokenProvider;


    // 인증이 성공한 경우 호출
    // 인증된 사용자를 대상 URL로 리다이렉트
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {

        // 인증 정보를 기반으로 JWT 토큰 생성
        String token = tokenProvider.createToken(authentication);


        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(objectMapper.writeValueAsString(Collections.singletonMap("token", token)));

    }





}
