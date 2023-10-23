package com.example.elasticsearch.model.dto.restaurant;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class WaitingTimeResponse {
    private String timeZone;
    private int expectedWaitingTime;
}
