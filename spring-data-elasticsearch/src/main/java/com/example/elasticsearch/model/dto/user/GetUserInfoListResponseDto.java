package com.example.elasticsearch.model.dto.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetUserInfoListResponseDto {

    private String userSeq;
    private String userNicknameContent;
    private String userProfileUrl;

    public void setEmptyProfileUrl(){
        this.setUserProfileUrl("http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg");
    }
}
