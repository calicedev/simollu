package com.simollu.Alert.respository;

import com.simollu.Alert.model.entity.Alert;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface AlertRepository extends JpaRepository<Alert, Long> {
    Optional<List<Alert>> findByUserSeqOrderByAlertSeqDesc(@Param("userSeq") String userSeq);

    @Modifying
    @Transactional(readOnly = false)
    @Query("update Alert a set a.alertIsRead = 1 where a.alertSeq between :startSeq and :endSeq")
    void readAlert(@Param("startSeq")Long startSeq, @Param("endSeq")Long endSeq);
}
