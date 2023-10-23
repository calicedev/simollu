package com.simollu.UserService.entity;


import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user_profile")
public class UserProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_profile_seq")
    private long userProfileSeq;

    @Column(name = "user_seq")
    private String userSeq;

    @Column(name = "user_profile_url")
    private String userProfileUrl;

    @CreatedDate
    @Builder.Default
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "user_profile_register_date")
    private LocalDateTime userProfileRegisterDate = LocalDateTime.now();

}
