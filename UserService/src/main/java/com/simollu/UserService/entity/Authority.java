package com.simollu.UserService.entity;


/*
사용자의 권한을 나타내는 엔티티
 */

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "authority")
public class Authority {

    @Id
    @Column(name = "authority_name")
    private String authorityName;

}
