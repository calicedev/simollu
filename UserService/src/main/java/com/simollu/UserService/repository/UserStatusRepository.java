package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserNickname;
import com.simollu.UserService.entity.UserStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserStatusRepository extends JpaRepository<UserStatus, Long> {

    // 가장 최근 내역 조회
    UserStatus findTopByUserSeqOrderByUserStatusDateDesc(String userSeq);

}
