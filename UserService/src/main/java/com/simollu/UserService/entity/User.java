package com.simollu.UserService.entity;


import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
@Table(name = "user")
public class User {

    @Id
    @Column(name = "user_seq")
    private String userSeq;

    // userSeq에 UUID 부여
    @PrePersist
    public void generateUserSeq() {
        if (this.userSeq == null || this.userSeq.isEmpty()) {
            this.userSeq = UUID.randomUUID().toString();
        }
    }

    @Column(name = "user_kakao")
    private String userKakao;

    @CreatedDate
    @Builder.Default
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "user_register_date")
    private LocalDateTime userRegisterDate = LocalDateTime.now();


    @ManyToMany
    @JoinTable(
            name = "user_authority",
            joinColumns = {@JoinColumn(name = "user_seq", referencedColumnName = "user_seq")},
            inverseJoinColumns = {@JoinColumn(name = "authority_name", referencedColumnName = "authority_name")})
    private Set<Authority> userAuthority;

}
