//
//  Models.swift
//  MovieApp
//
//  Created by Achem Samuel on 9/21/19.
//

import Foundation

struct MoviesResponse : Codable {
    
    var currentPage : Int
    var totalPages : Int
    var totalResults : Int
    var movies : [Movies]
    
    enum CodingKeys : String, CodingKey {
        case currentPage = "page"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
}

struct Movies : Codable {
    var posterPath : String
    
    enum CodingKeys : String, CodingKey {
        case posterPath = "poster_path"
    }
}


