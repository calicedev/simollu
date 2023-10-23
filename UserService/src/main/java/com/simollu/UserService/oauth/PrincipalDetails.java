package com.simollu.UserService.oauth;

import com.simollu.UserService.entity.Authority;
import com.simollu.UserService.entity.User;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import javax.transaction.Transactional;
import java.util.*;

@Data
public class PrincipalDetails implements OAuth2User {

    // 최초 가입 여부 확인
    private boolean initial;


    private User user;
    private Map<String, Object> attributes;
    private String provider;

    public PrincipalDetails(User user) {
        this.user = user;
    }

    public PrincipalDetails(User user, Map<String, Object> attributes, boolean initial) {
        this.user = user;
        this.attributes = attributes;
        this.initial = initial;
    }

    /**
     * 유저의 권한을 리턴하는 메소드
     *
     * @return
     */
    @Override
    @Transactional
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> listRole = new ArrayList<>();

        Set<Authority> userAuthority = user.getUserAuthority();
        for (Authority auth : userAuthority) {
            listRole.add(new SimpleGrantedAuthority(auth.getAuthorityName()));
        }

        // listRole.add(new SimpleGrantedAuthority("ROLE_USER"));
        return listRole;
    }

    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }

    // 카카오 로그인만 하므로 이 메소드에 유저의 고유식별자를 넘겨줘야한다.
    @Override
    public String getName() {
        return user.getUserKakao();
    }


    public boolean isInitial() {
        return initial;
    }


}
