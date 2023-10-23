package com.example.elasticsearch.model.document;

import com.example.elasticsearch.model.entity.Search;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Mapping;
import org.springframework.data.elasticsearch.annotations.Setting;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Document(indexName = "search")
@Mapping(mappingPath = "elastic/search-mapping.json")
@Setting(settingPath = "elastic/search-setting.json")
public class SearchDocument {
    @Id
    private Long searchSeq;
    private String searchWord;

    private Long searchRegsistDate;

    public static SearchDocument from(Search search) throws IOException {
        return SearchDocument.builder()
                .searchSeq(search.getSearchSeq())
                .searchWord(search.getSearchWord())
                .searchRegsistDate(search.getSearchRegistDate())
                .build();
    }

}
