package com.simollu.WaitingService.model.dto.alert;

import lombok.Getter;

@Getter
public enum AlertMessage {
    WAITING_REGIST_ALERT("웨이팅 알림", "웨이팅 등록이 완료되었습니다.", "WAITING_REGIST"),
    WAITING_CANCEL_ALERT("웨이팅 알림", "웨이팅 취소 처리가 완료되었습니다.", "WAITING_CANCEL"),
    WAITING_CHANGE_ALERT("웨이팅 알림", "웨이팅 순서 미루기가 완료되었습니다.", "WAITING_CHANGE"),
    COME_IN_PLEASE_ALERT("입장 알림", "입장해 주세요.", "COME_IN_PLEASE"),
    TEAMS_LEFT_2_ALERT("웨이팅 알림", "앞에 대기 2팀 남았습니다.", "TEAMS_LEFT_2"),
    TEAMS_LEFT_3_ALERT("웨이팅 알림", "앞에 대기 3팀 남았습니다.", "TEAMS_LEFT_3"),
    WRITEABLE_REVIEW_ALERT("리뷰 알림", "식사는 맛있게 하셨나요? 리뷰를 등록하시면 포크를 드려요!", "WRITEABLE_REVIEW")
    ;


    private final String title;
    private final String message;
    private final String code;

    private AlertMessage(String title, String message, String code) {
        this.title = title;
        this.message = message;
        this.code = code;
    }


}
