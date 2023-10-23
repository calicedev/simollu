package com.example.elasticsearch.model.dto.search;

import java.io.IOException;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class SearchRankResponse {
    private int searchRank;
    private String searchWord;
}
