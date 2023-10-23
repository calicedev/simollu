package com.example.elasticsearch.model.dto.menu;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class MenuInfoResponse {
    private Long menuSeq;
    private String menuName;
    private String menuImage;
    private String menuPrice;

}
