package com.simollu.WaitingService.model.entity;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.IOException;
import java.io.Serializable;

/* 대기 */
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "waiting")
@Builder
public class Waiting implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer waitingSeq; // 대기일련번호
    @NotNull
    @Column(name = "user_seq")
    private String userSeq; // 회원일련번호

    @NotNull
    @Column(name = "restaurant_seq")
    private Integer restaurantSeq; // 식당일련번호

    @NotNull
    @Column(name = "waiting_person_cnt")
    private int waitingPersonCnt; // 대기 인원

    @NotNull
    @Column(name = "waiting_no")
    private int waitingNo; // 대기 번호(변하지 않는 대기번호)

    @NotNull
    @Column(name = "restaurant_name", length=20)
    private String restaurantName; // 식당이름

    public static Waiting JsonToEntity(String jsonWaiting) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(jsonWaiting, Waiting.class);
    }

}//WaitingEntity
