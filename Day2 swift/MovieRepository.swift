//
//  MovieRepository.swift
//  Day2 swift
//
//  Created by Kerolos on 04/05/2025.
//

import Foundation
import CoreData


class MovieRepository {
    private let coreDataStack = AppDelegate.shared
    private let apiUrl = "https://dummyjson.com/c/8b9b-3f93-4c8d-a8b9"
    
    
    func fetchMovies(forceRefresh: Bool = false, completion: @escaping ([Movie]) -> Void) {
        if NetworkMonitor.shared.isConnected && forceRefresh {
            fetchMoviesFromAPI { [weak self] movies in
                guard let self = self else { return }
                
                if !movies.isEmpty {
                    self.saveMoviesToCoreData(movies)
                    completion(movies)
                } else {
                    let localMovies = self.fetchMoviesFromCoreData()
                    completion(localMovies)
                }
            }
        } else {
            let localMovies = fetchMoviesFromCoreData()
            
            if !localMovies.isEmpty {
                completion(localMovies)
                return
            }
            
            if NetworkMonitor.shared.isConnected {
                fetchMoviesFromAPI { [weak self] movies in
                    guard let self = self else { return }
                    self.saveMoviesToCoreData(movies)
                    completion(movies)
                }
            } else {
                completion([])
            }
        }
    }
    
    func addMovie(_ movie: Movie, completion: @escaping (Bool) -> Void) {
        let context = coreDataStack.viewContext
        
        let existing = fetchExistingMovie(title: movie.Title, year: movie.Year)
        
        if existing == nil {
            let entity = MovieEntity(context: context)
            entity.update(from: movie)
            
            coreDataStack.saveContext()
            completion(true)
        } else {
            completion(false)
        }
    }
    
    
    private func fetchMoviesFromCoreData() -> [Movie] {
        let context = coreDataStack.viewContext
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            let movieEntities = try context.fetch(fetchRequest)
            return movieEntities.map { Movie.from(entity: $0) }
        } catch {
            print("Error fetching from Core Data: \(error)")
            return []
        }
    }
    
    private func fetchExistingMovie(title: String, year: String) -> MovieEntity? {
        let context = coreDataStack.viewContext
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND year == %@", title, year)
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Error checking for existing movie: \(error)")
            return nil
        }
    }
    
    private func fetchMoviesFromAPI(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion([])
                return
            }
            
            do {
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                completion(movies)
            } catch {
                print("Error decoding JSON: \(error)")
                completion([])
            }
        }.resume()
    }
    
    private func saveMoviesToCoreData(_ movies: [Movie]) {
        let context = coreDataStack.viewContext
        
        for movie in movies {
            if let existingEntity = fetchExistingMovie(title: movie.Title, year: movie.Year) {
                existingEntity.update(from: movie)
            } else {
                let newEntity = MovieEntity(context: context)
                newEntity.update(from: movie)
            }
        }
        
        coreDataStack.saveContext()
    }
}
