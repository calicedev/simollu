package com.simollu.UserService.repository;

import com.simollu.UserService.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String> {

    boolean existsByUserKakao(String kakao);

    // 권한을 함께 가져오는 조회
    @Query("SELECT u FROM User u JOIN FETCH u.userAuthority WHERE u.userKakao = :userKakao")
    Optional<User> findByUserKakaoWithAuthorities(@Param("userKakao") String userKakao);



}
