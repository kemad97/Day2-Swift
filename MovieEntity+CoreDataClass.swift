//
//  MovieEntity+CoreDataClass.swift
//  Day2 swift
//
//  Created by Kerolos on 04/05/2025.
//
//

import Foundation
import CoreData

@objc(MovieEntity)
public class MovieEntity: NSManagedObject {

}

extension MovieEntity {
    // Update or populate entity from a Movie
    func update(from movie: Movie) {
        self.title = movie.Title
        self.year = movie.Year
        self.rated = movie.Rated
        self.director = movie.Director
        self.poster = movie.Poster
        self.imdbRating = movie.imdbRating
    }
}
