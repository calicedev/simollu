package com.example.elasticsearch.repository.elkBasic;

import com.example.elasticsearch.model.document.SearchDocument;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SearchElasticBasicRepository extends ElasticsearchRepository<SearchDocument,Long> {

}
