//
//  Movie.swift
//  Netflix_Clone
//
//  Created by Lina on 28/11/22.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}
struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String? // Could it be a Date?
    let vote_average: Double
}
