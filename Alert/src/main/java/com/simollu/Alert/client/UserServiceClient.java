package com.simollu.Alert.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;


@FeignClient(name = "user-service")
public interface UserServiceClient {

    @GetMapping("/user/firebase-token")
    String getUserFirebaseToken(@RequestHeader("userSeq") String userSeq);

}
