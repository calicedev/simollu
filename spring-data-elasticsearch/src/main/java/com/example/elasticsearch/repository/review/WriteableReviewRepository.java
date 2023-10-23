package com.example.elasticsearch.repository.review;

import com.example.elasticsearch.model.entity.WriteableReview;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WriteableReviewRepository extends JpaRepository<WriteableReview, Long> {


}
