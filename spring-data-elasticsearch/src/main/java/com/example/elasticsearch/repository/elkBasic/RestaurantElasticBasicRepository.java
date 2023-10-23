package com.example.elasticsearch.repository.elkBasic;

import com.example.elasticsearch.model.document.RestaurantDocument;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RestaurantElasticBasicRepository extends ElasticsearchRepository<RestaurantDocument,Long> {
}

