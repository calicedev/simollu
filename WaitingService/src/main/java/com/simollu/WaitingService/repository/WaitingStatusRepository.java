package com.simollu.WaitingService.repository;

import com.simollu.WaitingService.model.entity.WaitingStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface WaitingStatusRepository extends JpaRepository<WaitingStatus, Integer> {

    @Query(value = "select * from Waiting_Status s where s.waiting_seq = :waitingSeq " +
            "and s.waiting_status_content = :waitingStatusContent", nativeQuery = true)
    Optional<WaitingStatus> findByWaitingSeqAndWaitingStatusContent(
            @Param("waitingSeq") Integer waitingSeq
            , @Param("waitingStatusContent")int waitingStatusContent);
}//WaitingStatusRepository
