package com.simollu.WaitingService.client;

import com.simollu.WaitingService.model.dto.review.WriteableReviewDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(name = "restaurant-service")
public interface RestaurantServiceClient {

    @PostMapping("/review/writeable")
    void addWriteableReview(@RequestBody WriteableReviewDto writeableReviewDto);

}
