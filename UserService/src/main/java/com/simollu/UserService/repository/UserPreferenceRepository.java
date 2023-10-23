package com.simollu.UserService.repository;

import com.simollu.UserService.entity.UserPreference;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserPreferenceRepository extends JpaRepository<UserPreference, Long> {

    void deleteAllByUserSeq(String userSeq);

    List<UserPreference> findAllByUserSeq(String userSeq);

}
