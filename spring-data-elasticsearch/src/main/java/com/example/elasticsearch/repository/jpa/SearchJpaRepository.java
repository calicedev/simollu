package com.example.elasticsearch.repository.jpa;

import com.example.elasticsearch.model.entity.Search;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface SearchJpaRepository extends JpaRepository<Search, Long> {

}
