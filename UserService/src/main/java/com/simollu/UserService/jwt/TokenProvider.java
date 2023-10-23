package com.simollu.UserService.jwt;


import com.simollu.UserService.dto.user.UserInfoJwtDto;
import com.simollu.UserService.oauth.PrincipalDetails;
import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;


import javax.crypto.SecretKey;
import java.util.*;
import java.util.stream.Collectors;

@Component
public class TokenProvider implements InitializingBean {


    private final Logger logger = LoggerFactory.getLogger(TokenProvider.class);
    private static final String AUTHORITIES_KEY = "authority"; // 권한
    private final String secret;
    private final long tokenValidityInMilliseconds;
    private SecretKey key;


    // 처음 값 주입
    public TokenProvider(
            @Value("${jwt.secret}") String secret,
            @Value("${jwt.token-validate-time}") long tokenValidityInSeconds) {
        this.secret = secret;
        this.tokenValidityInMilliseconds = tokenValidityInSeconds * 1000;
    }


    @Override
    public void afterPropertiesSet() {
        byte[] keyBytes = Decoders.BASE64.decode(secret);
        this.key = Keys.hmacShaKeyFor(keyBytes);
    }


    // Authentication 객체의 권한 정보를 이용해서 Token을 생성하는 메소드
    public String createToken(Authentication authentication) {

        List<String> authorities = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());

        long now = (new Date()).getTime();
        PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();

        // 토큰에 담을 정보
        String userSeq = principalDetails.getUser().getUserSeq();

        // 토큰 유효 시간
        Date validity = new Date(now + this.tokenValidityInMilliseconds);


        return Jwts.builder()
                .setSubject(userSeq)
                .claim(AUTHORITIES_KEY, authorities) // 권한 정보
                .signWith(SignatureAlgorithm.HS256, key) // jwt에 서명할 암호화 키와 알고리즘을 설정
                .setExpiration(validity) // jwt 만료 시간 설정
                .compact();
    }


    public Authentication getAuthentication(String token) {

        // 토큰 복호화
        Jws<Claims> parsedJwt = Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token);

        Claims claims = parsedJwt.getBody();

        if (claims.get(AUTHORITIES_KEY) == null) {
            throw new RuntimeException("권한 정보가 없는 토큰입니다.");
        }

        // 클레임에서 권한 정보 가져오기
        List<String> authorities = (List<String>) claims.get(AUTHORITIES_KEY);
        List<GrantedAuthority> grantedAuthorities = authorities.stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());


        // UserDetails 객체를 만들어서 Authentication 리턴
        UserDetails principal = new org.springframework.security.core.userdetails.User(
                claims.getSubject(), "", grantedAuthorities);

        return new UsernamePasswordAuthenticationToken(principal, "", grantedAuthorities);

    }




    // token 유효성 검증 메소드
    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
            return true;
        } catch (io.jsonwebtoken.security.SecurityException | MalformedJwtException e) {
            logger.info("잘못된 JWT 서명입니다.");
        } catch (ExpiredJwtException e) {
            logger.info("만료된 JWT 토큰입니다.");
        } catch (UnsupportedJwtException e) {
            logger.info("지원되지 않는 JWT 토큰입니다.");
        } catch (IllegalArgumentException e) {
            logger.info("JWT 토큰이 잘못되었습니다.");
        }
        return false;
    }



    // token에서 사용자 정보 추출
    public UserInfoJwtDto getUserInfo(String token) {

        Claims claims = Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();

        List<String> authorities = (List<String>) claims.get(AUTHORITIES_KEY);

        UserInfoJwtDto userInfoJwtDto = UserInfoJwtDto.builder()
                .userSeq(claims.getSubject())
                .userAuthority(authorities)
                .userNicknameContent(claims.get("userNickname", String.class))
                .userProfileUrl(claims.get("userProfileUrl", String.class))
                .build();

        return userInfoJwtDto;
    }


}
