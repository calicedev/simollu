package com.simollu.CalculatorService.repository;

import com.simollu.CalculatorService.entity.WaitingLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface WaitingLogRepository extends JpaRepository<WaitingLog, Integer> {

    // 타켓 날짜에 해당하는 모든 정보를 가져옵니다.
    List<WaitingLog> findByWaitingStatusRegistDateBetween(LocalDateTime start, LocalDateTime end);




    @Query(value = "SELECT w.restaurant_seq, HOUR(w.waiting_status_entrance_date) as entranceHour, ROUND(AVG(w.waiting_log_time)) as averageWaitingTime " +
            "FROM waiting_log w " +
            "WHERE w.waiting_status_entrance_date BETWEEN :twoWeeksAgo AND :oneWeekAgo " +
            "GROUP BY w.restaurant_seq, entranceHour, DAYOFWEEK(w.waiting_status_entrance_date) " +
            "ORDER BY w.restaurant_seq, entranceHour, DAYOFWEEK(w.waiting_status_entrance_date)", nativeQuery = true)
    List<Object[]> findAverageWaitingTimeByRestaurantAndWeekdayHour(@Param("twoWeeksAgo") LocalDateTime twoWeeksAgo,
                                                                    @Param("oneWeekAgo") LocalDateTime oneWeekAgo);





}
