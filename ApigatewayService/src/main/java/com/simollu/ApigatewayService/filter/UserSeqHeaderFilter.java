package com.simollu.ApigatewayService.filter;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import lombok.extern.java.Log;
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
public class UserSeqHeaderFilter extends AbstractGatewayFilterFactory<UserSeqHeaderFilter.Config> {

    private Environment env;

    public UserSeqHeaderFilter(Environment env) {
        super(Config.class);
        this.env = env;
    }

    public static class Config {

    }

    @Override
    public GatewayFilter apply(Config config) {
        return (exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest();

            System.out.println("userHeader 작동");

            if (!request.getHeaders().containsKey(HttpHeaders.AUTHORIZATION)) {
                return onError(exchange, "UserSeqHeaderFilter - no authorization header", HttpStatus.UNAUTHORIZED);
            }

            String jwt = request.getHeaders().get(HttpHeaders.AUTHORIZATION).get(0);
            String userSeq;
            try {
                userSeq = extractUserSeqFromJwt(jwt);
            } catch (Exception e) {
                return onError(exchange, "Error extracting userSeq from JWT", HttpStatus.UNAUTHORIZED);
            }

            ServerHttpRequest modifiedRequest = request.mutate()
                    .header("userSeq", userSeq)
                    .build();

            return chain.filter(exchange.mutate().request(modifiedRequest).build());

        };
    }

    private String extractUserSeqFromJwt(String jwt) {
        return Jwts.parser().setSigningKey(env.getProperty("jwt.secret"))
                .parseClaimsJws(jwt).getBody()
                .getSubject();
    }


    private Mono<Void> onError(ServerWebExchange exchange, String err, HttpStatus httpStatus) {
        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(httpStatus);

        log.error(err);
        return response.setComplete();
    }


}
