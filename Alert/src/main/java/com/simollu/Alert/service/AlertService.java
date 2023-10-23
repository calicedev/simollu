package com.simollu.Alert.service;

import com.simollu.Alert.model.dto.AlertDto;
import com.simollu.Alert.model.dto.AlertReadRequestDto;
import com.simollu.Alert.model.dto.AlertSeqDto;

import java.util.List;

public interface AlertService {

    /* 알림 생성 */
    /* 알림 리스트 조회 */
    List<AlertDto> getAlertList(String userSeq);

    /* 알림 조회 */
    AlertDto getAlertDetail(Long alertSeq);

    /* 알림 읽음 */
    boolean readAlertList(AlertReadRequestDto readRequestDto);

    /* 알림 삭제 */
    boolean deleteAlertList(List<AlertSeqDto> seqDtoList);

}
