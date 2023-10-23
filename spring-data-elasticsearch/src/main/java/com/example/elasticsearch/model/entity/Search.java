package com.example.elasticsearch.model.entity;

import com.example.elasticsearch.model.dto.search.SearchSaveRequest;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class Search {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "search_seq")
    private Long searchSeq;

    @Column(name = "search_word")
    private String searchWord;
    @Column(name = "search_regist_date")
    private Long searchRegistDate;

    public static Search from (SearchSaveRequest searchSaveRequest){
        return Search.builder()
                .searchWord(searchSaveRequest.getSearchWord())
                .build();
    }
}
