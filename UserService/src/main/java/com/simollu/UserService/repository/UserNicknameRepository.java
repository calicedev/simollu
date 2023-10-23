package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserForkLog;
import com.simollu.UserService.entity.UserNickname;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserNicknameRepository extends JpaRepository<UserNickname, Long> {

    // 가장 최근의 내역 가져오기
    UserNickname findTopByUserSeqOrderByUserNicknameRegisterDateDesc(String userSeq);

}
