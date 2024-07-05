package com.musa.spring.review;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.musa.spring.company.Company;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String description;
    private double rating;

   @JsonIgnore
    @ManyToOne
    private Company company;
}
