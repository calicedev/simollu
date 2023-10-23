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
@Table(name = "user_nickname")
public class UserNickname {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_nickname_seq")
    private long userNicknameSeq;

    @Column(name = "user_seq")
    private String userSeq;

    @Column(name = "user_nickname_content")
    private String userNicknameContent;

    @CreatedDate
    @Builder.Default
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "user_nickname_register_date")
    private LocalDateTime userNicknameRegisterDate = LocalDateTime.now();
}
