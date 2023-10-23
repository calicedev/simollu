package com.example.elasticsearch.model.dto.search;

import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SearchSaveRequest {
    private String searchWord;
    private LocalDateTime timestamp;

}
