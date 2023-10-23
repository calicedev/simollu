package com.simollu.WaitingService.repository;

import com.simollu.WaitingService.model.dto.WaitingHistoryDto;
import com.simollu.WaitingService.model.entity.Waiting;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WaitingRepository extends JpaRepository<Waiting, Integer> {

    @Query(value = "select w.waiting_No from waiting w " +
            "join waiting_status s on w.waiting_seq = s.waiting_seq " +
            "where s.waiting_status_regist_date >= :now and w.restaurant_seq = :restaurantSeq " +
            "order by s.waiting_status_regist_date desc limit 1 ", nativeQuery = true)
    Optional<Integer> findByWaitingNo(String now, Integer restaurantSeq);

    @Query("select new com.simollu.WaitingService.model.dto.WaitingHistoryDto(w.waitingSeq, w.userSeq, w.restaurantSeq" +
            ", w.waitingNo, w.restaurantName, ws.waitingStatusRegistDate, ws.waitingStatusContent, w.waitingPersonCnt) " +
            "from Waiting w join WaitingStatus ws on ws.waitingSeq = w.waitingSeq " +
            "where w.userSeq = :userSeq and ws.waitingStatusContent = :waitingStatusContent " +
            "order by ws.waitingStatusRegistDate desc ")
    Optional<List<WaitingHistoryDto>> findByUserSeqAndWaitingStatusContent(
            @Param("userSeq") String userSeq, @Param("waitingStatusContent")int waitingStatusContent);

}//WaitingRepository
