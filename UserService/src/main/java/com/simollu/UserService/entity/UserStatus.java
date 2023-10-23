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
@Table(name = "user_status")
public class UserStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_status_seq")
    private long userStatusSeq;
    @Column(name = "user_seq")
    private String userSeq;
    @Column(name = "user_status_content")
    private int userStatusContent;

    @CreatedDate
    @Builder.Default
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "user_status_date")
    private LocalDateTime userStatusDate = LocalDateTime.now();


}
