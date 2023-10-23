package com.simollu.Alert.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.simollu.Alert.client.UserServiceClient;
import com.simollu.Alert.model.dto.NotificationRequestDto;
import com.simollu.Alert.model.entity.Alert;
import com.simollu.Alert.respository.AlertRepository;
import com.simollu.Alert.utils.DateTimeUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class FcmNotificationService {
    private final FirebaseMessaging firebaseMessaging;
    private final UserServiceClient userServiceClient;
    private final AlertRepository alertRepository;
    private final RedisService redisService;

    public int sendNotificationByToken(NotificationRequestDto requestDto) {

        String token = userServiceClient.getUserFirebaseToken(requestDto.getTargetUserSeq());

        if(token.equals("null")) return HttpStatus.NO_CONTENT.value();

        Notification notification = Notification.builder()
                .setTitle(requestDto.getTitle())
                .setBody(requestDto.getBody())
                .build();
        Message message = Message.builder()
                .setToken(token)
                .setNotification(notification)
                .putData("code", requestDto.getCode())
                .build();

        try {
            firebaseMessaging.send(message);
            Alert alert = Alert.builder()
                    .userSeq(requestDto.getTargetUserSeq())
                    .alertTitle(requestDto.getTitle())
                    .alertContent(requestDto.getBody())
                    .alertRegistDate(DateTimeUtils.nowFromZone())
                    .build();
            alertRepository.save(alert);
            return HttpStatus.OK.value();
        }catch (FirebaseMessagingException e){
            log.error("fcm error {}", e.getMessage());
            return HttpStatus.INTERNAL_SERVER_ERROR.value();
        }
    }//sendNotificationByToken

}
