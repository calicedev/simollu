package com.simollu.ApigatewayService.config;


import java.util.Arrays;
import java.util.HashMap;
import org.springframework.cloud.gateway.handler.RoutePredicateHandlerMapping;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.reactive.config.CorsRegistry;
import org.springframework.web.reactive.config.EnableWebFlux;
import org.springframework.web.reactive.config.WebFluxConfigurer;

@Configuration
@EnableWebFlux
public class CorsGlobalConfiguration implements WebFluxConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry corsRegistry) {
        corsRegistry.addMapping("/**")
                .allowedOriginPatterns("*","http://localhost:3000", "https://simollu.com")
                .allowedMethods("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }


//    @Bean
//    @Order(Ordered.HIGHEST_PRECEDENCE)
//    public CorsConfiguration corsConfiguration(
//            RoutePredicateHandlerMapping routePredicateHandlerMapping) {
//        CorsConfiguration corsConfiguration = new CorsConfiguration().applyPermitDefaultValues();
//
//        Arrays.asList(HttpMethod.OPTIONS, HttpMethod.PUT, HttpMethod.GET, HttpMethod.DELETE, HttpMethod.POST) .forEach(m -> corsConfiguration.addAllowedMethod(m));
//        corsConfiguration.addAllowedOrigin("*");
//        corsConfiguration.addAllowedMethod(HttpMethod.POST);
//        routePredicateHandlerMapping.setCorsConfigurations(new HashMap<String, CorsConfiguration>() {{ put("/**", corsConfiguration); }});
//        return corsConfiguration;
//    }
}

