package com.simollu.UserService.handler;


import com.simollu.UserService.jwt.TokenProvider;
import com.simollu.UserService.oauth.PrincipalDetails;
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

@Component
@RequiredArgsConstructor
public class OAuth2AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {


    private final TokenProvider tokenProvider;
    private final UserService userService;

    // 인증이 성공한 경우 호출
    // 인증된 사용자를 대상 URL로 리다이렉트
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {

        // redirect 할 url을 지정해준다
        String targetUrl = determineTargetUrl(request, response, authentication);

        if (response.isCommitted()) {
            logger.debug("OAuth2AuthenticationSuccessHandler - Response has already been committed. Unable to redirect to " + targetUrl);
            return;
        }

        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }

    // 인증된 사용자를 리다이렉트할 대상 URL을 결정
    protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) {

        // String targetUrl = "/except/login-success?";
        String targetUrl = "/login-success?";

        // 인증 정보를 기반으로 JWT 토큰 생성
        String token = tokenProvider.createToken(authentication);

        // initial 값을 가져옵니다.
        boolean initial = false;
        if (authentication.getPrincipal() instanceof PrincipalDetails) {
            initial = ((PrincipalDetails) authentication.getPrincipal()).isInitial();
        }

        // URL 쿼리 파라미터로 token 추가
        return UriComponentsBuilder.fromUriString(targetUrl)
                .queryParam("token", token)
                .queryParam("initial", initial)
                .build().toUriString();
    }



}
