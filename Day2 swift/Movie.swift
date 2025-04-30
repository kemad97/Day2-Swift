//
//  Movie.swift
//  Day2 swift
//
//  Created by Kerolos on 30/04/2025.
//

import Foundation
import UIKit

struct Movie {
    var id: Int?
    var title: String
    var genre: String
    var releaseYear: Int
    var rating: Double
    var image: UIImage?
    
    init(id: Int? = nil, title: String, genre: String, releaseYear: Int, rating: Double, image: UIImage? = nil) {
        self.id = id
        self.title = title
        self.genre = genre
        self.releaseYear = releaseYear
        self.rating = rating
        self.image = image
    }
}
