//
//  Movie.swift
//  Day2 swift
//
//  Created by Kerolos on 03/05/2025.
//

import Foundation

struct Movie: Codable {
    
    let Title: String
    let Year: String
    let Rated: String
    let Director: String
    let Poster: String
    let imdbRating: String
    
}

extension Movie {
    // Create a Movie from a MovieEntity
    static func from(entity: MovieEntity) -> Movie {
        return Movie(
            Title: entity.title ?? "",
            Year: entity.year ?? "",
            Rated: entity.rated ?? "",
            Director: entity.director ?? "",
            Poster: entity.poster ?? "",
            imdbRating: entity.imdbRating ?? ""
        )
    }
}
