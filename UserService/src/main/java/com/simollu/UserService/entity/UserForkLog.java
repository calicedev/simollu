package com.simollu.UserService.entity;


import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "user_fork_log")
public class UserForkLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_fork_seq")
    private long userForkSeq;

    @Column(name = "user_seq")
    private String userSeq;
    @Column(name = "user_fork_amount")
    private int userForkAmount;
    @Column(name = "user_fork_balance")
    private int userForkBalance;
    @Column(name = "user_fork_type")
    private String userForkType;
    @Column(name = "user_fork_content")
    private String userForkContent;

    @CreatedDate
    @Builder.Default
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "user_fork_register_date")
    private LocalDateTime userForkRegisterDate = LocalDateTime.now();



}
