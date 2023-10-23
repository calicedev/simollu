package com.example.elasticsearch.repository.review;

import com.example.elasticsearch.model.dto.review.MyReviewDto;
import com.example.elasticsearch.model.dto.review.WriteableReviewDto;
import com.example.elasticsearch.model.entity.Review;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByRestaurantSeq(@Param("restaurantSeq") Long restaurantSeq);

    @Query("select new com.example.elasticsearch.model.dto.review.MyReviewDto(r.reviewSeq, r.userSeq, r.restaurantSeq, r.reviewRating" +
            ", r.reviewContent, r.reviewRegistDate, rs.restaurantName, rs.restaurantImg) " +
            "from Review r join Restaurant rs on r.restaurantSeq = rs.restaurantSeq " +
            "where r.userSeq = :userSeq ")
    Optional<List<MyReviewDto>> getReviewByUserSeq(@Param("userSeq") String userSeq);

    // 회원 작성 가능 리뷰 리스트 조회
    @Query("select new com.example.elasticsearch.model.dto.review.WriteableReviewDto(wr.writeableSeq, wr.userSeq, wr.restaurantSeq, " +
            "wr.waitingCompleteDate, r.restaurantName, r.restaurantImg) " +
            "from WriteableReview wr join Restaurant r on wr.restaurantSeq = r.restaurantSeq " +
            "where wr.userSeq = :userSeq")
    Optional<List<WriteableReviewDto>> getWriteableList(@Param("userSeq") String userSeq);

}
