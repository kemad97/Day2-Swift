//
//  MovieEntity+CoreDataProperties.swift
//  Day2 swift
//
//  Created by Kerolos on 04/05/2025.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var year: String?
    @NSManaged public var rated: String?
    @NSManaged public var director: String?
    @NSManaged public var poster: String?
    @NSManaged public var imdbRating: String?
    @NSManaged public var id: String?

}

extension MovieEntity : Identifiable {

}
extension MovieEntity {
    func update( movie: Movie) {
        self.title = movie.Title
        self.year = movie.Year
        self.rated = movie.Rated
        self.director = movie.Director
        self.poster = movie.Poster
        self.imdbRating = movie.imdbRating
    }
}
