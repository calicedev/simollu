package com.simollu.WaitingService.client;

import com.simollu.WaitingService.model.dto.alert.NotificationRequestDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@FeignClient(name = "alert-service")
public interface AlertServiceClient {

    @PostMapping("/alert")
    ResponseEntity<?> sendNotificationByToken(@RequestBody NotificationRequestDto requestDto);

}
