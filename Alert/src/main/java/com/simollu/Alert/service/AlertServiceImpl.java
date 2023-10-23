package com.simollu.Alert.service;

import com.simollu.Alert.model.dto.AlertDto;
import com.simollu.Alert.model.dto.AlertReadRequestDto;
import com.simollu.Alert.model.dto.AlertSeqDto;
import com.simollu.Alert.model.entity.Alert;
import com.simollu.Alert.respository.AlertRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class AlertServiceImpl implements AlertService {

    private final AlertRepository alertRepository;

    /* 알림 리스트 조회 */
    @Override
    public List<AlertDto> getAlertList(String userSeq) {
        List<Alert> alertList = alertRepository.findByUserSeqOrderByAlertSeqDesc(userSeq).orElse(new ArrayList<>());
        if(alertList.isEmpty()) return null;

        List<AlertDto> alertDtoList = new ArrayList<>();
        for(Alert alert : alertList) {
            alertDtoList.add(new AlertDto(alert));
        }
        return alertDtoList;
    }

    /* 알림 조회 */
    @Override
    public AlertDto getAlertDetail(Long alertSeq) {
        Alert alert = alertRepository.findById(alertSeq).orElse(null);
        if(alert == null) return null;

        AlertDto alertDto = new AlertDto(alert);
        return alertDto;
    }

    /* 알림 읽음 */
    @Override
    public boolean readAlertList(AlertReadRequestDto readRequestDto) {
        alertRepository.readAlert(readRequestDto.getStartSeq(), readRequestDto.getEndSeq());
        return true;
    }

    /* 알림 삭제 */
    @Override
    public boolean deleteAlertList(List<AlertSeqDto> seqDtoList) {
        for (AlertSeqDto alertSeqDto : seqDtoList){
            alertRepository.deleteById(alertSeqDto.getAlertSeq());
        }
        return true;
    }

}
