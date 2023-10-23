package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserNickname;
import com.simollu.UserService.entity.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserProfileRepository extends JpaRepository<UserProfile, Long> {

    // 가장 최근의 내역 가져오기
    UserProfile findTopByUserSeqOrderByUserProfileRegisterDateDesc(String userSeq);


    // 몇 개 있는지 알아내기
    @Query("SELECT COUNT(u) FROM UserProfile u WHERE u.userSeq = ?1")
    long countByUserSeq(String userSeq);
}
