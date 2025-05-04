//
//  MovieRepository.swift
//  Day2 swift
//
//  Created by Kerolos on 04/05/2025.
//

import Foundation
import CoreData


class MovieRepository {
    private let coreData = AppDelegate.shared
    private let apiUrl = "https://dummyjson.com/c/8b9b-3f93-4c8d-a8b9"
    
    
    func fetchMovies(useApi: Bool = false, completion: @escaping ([Movie]) -> Void) {
        if NetworkMonitor.shared.isConnected && useApi {
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
        let context = coreData.viewContext
        
        let entity = MovieEntity(context: context)
        entity.update( movie: movie)

        coreData.saveContext()
        completion(true)
       
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func fetchMoviesFromCoreData() -> [Movie] {
        let context = coreData.viewContext
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do {
            let movieEntities = try context.fetch(fetchRequest)
            return movieEntities.map { Movie.from(entity: $0) }
        } catch {
            print("Error  \(error)")
            return []
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
        let context = coreData.viewContext
        
        for movie in movies {
            
            let newEntity = MovieEntity(context: context)
            newEntity.update(movie:movie)
           
            coreData.saveContext()
        }
    }
}
