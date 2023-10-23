package com.simollu.WaitingService.repository;


import com.simollu.WaitingService.model.entity.WaitingLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WaitingLogRepository extends JpaRepository<WaitingLog, Integer> {


}
