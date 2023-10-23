package com.simollu.ApigatewayService.filter;


import io.jsonwebtoken.Jwts;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Component
@Slf4j
public class AuthorizationHeaderFilter extends AbstractGatewayFilterFactory<AuthorizationHeaderFilter.Config> {

    Environment env;

    public AuthorizationHeaderFilter(Environment env) {
        super(Config.class); // config 정보를 부모 클래스에 알려줘야 한다.
        this.env = env;
    }

    public static class Config {

    }


    // login -> token -> users (with token) -> header(include token)
    @Override
    public GatewayFilter apply(Config config) {



        return (exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest();

            if (!request.getHeaders().containsKey(HttpHeaders.AUTHORIZATION)) {
                return onError(exchange, "AuthorizationHeaderFilter - no authorization header", HttpStatus.UNAUTHORIZED);
            }

            String jwt = request.getHeaders().get(HttpHeaders.AUTHORIZATION).get(0);


            if(!isJwtValid(jwt)) {
                return onError(exchange, "AuthorizationHeaderFilter - JWT token is not valid", HttpStatus.UNAUTHORIZED);
            }


            return chain.filter(exchange);
        };
    }


    private boolean isJwtValid(String jwt) {
        boolean returnValue = true;

        String subject = null;

        try {
            subject = Jwts.parser().setSigningKey(env.getProperty("jwt.secret"))
                    .parseClaimsJws(jwt).getBody()
                    .getSubject();
        } catch (Exception ex) {

            returnValue = false;
        }

        if (subject == null || subject.isEmpty()) {

            returnValue = false;
        }

        return returnValue;
    }

    // functional api, 비동기 방식, webflux
    // webflux 안에서 데이터를 처리하는 두 가지 단위 중 하나가 Mono 이다. 단일값이라 생각할 수 있다. 단일값이 아니면 flux를 사용한다.

    // 에러 발생
    // Mono, Flux -> Spring WebFlux 스프링5에서 나온 새로운 자료형
    private Mono<Void> onError(ServerWebExchange exchange, String err, HttpStatus httpStatus) {
        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(httpStatus);

        log.error(err);
        return response.setComplete();
    }


}
