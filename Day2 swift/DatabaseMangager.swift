//
//  DatabaseMangager.swift
//  Day2 swift
//
//  Created by Kerolos on 30/04/2025.
//

import Foundation
import UIKit
import SQLite3

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private var db: OpaquePointer?
    
    private init() {
        
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("MoviesDatabase.sqlite")
        
         sqlite3_open(fileURL.path, &db)
        
        
        createTables()
    }
    
    private func createTables() {
        
        let createTableString = """
        CREATE TABLE IF NOT EXISTS movies(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            genre TEXT,
            releaseYear INTEGER,
            rating REAL,
            imageData BLOB
        );
        """
        
        var createTableStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("db created successfully")
            } else {
                print("Failed to create movies table")
            }
        } else {
            print("Failed to prepare create table statement")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - CRUD Operations
    
    func insertMovie(_ movie: Movie) -> Int64? {
        let insertStatementString = "INSERT INTO movies (title, genre, releaseYear, rating, imageData) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK
        {
            
            sqlite3_bind_text(insertStatement, 1, (movie.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (movie.genre as NSString).utf8String, -1, nil)
            
            sqlite3_bind_int(insertStatement, 3, Int32(movie.releaseYear))
            sqlite3_bind_double(insertStatement, 4, movie.rating)
            
            if let image = movie.image, let imageData = image.jpegData(compressionQuality: 1.0)
            {
                let count = Int32(imageData.count)
                imageData.withUnsafeBytes { bytes in
                    let rawPointer = bytes.baseAddress
                    sqlite3_bind_blob(insertStatement, 5, rawPointer, count, nil)
                }
            } else {
                sqlite3_bind_null(insertStatement, 5)
            }
            
            if sqlite3_step(insertStatement) == SQLITE_DONE
            {
                print("Successfully inserted movie")
                let rowID = sqlite3_last_insert_rowid(db)
                sqlite3_finalize(insertStatement)
                return rowID
            }
            else {
                print("Failed to insert movie")
            }
        }
        else {
            print("INSERT statement could not be prepared")
        }
        
        sqlite3_finalize(insertStatement)
        return nil
    }
    
    func getAllMovies() -> [Movie] {
        var movies: [Movie] = []
        let queryStatementString = "SELECT * FROM movies;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW
            {
                
                let id = sqlite3_column_int64(queryStatement, 0)
                
                guard let titleCString = sqlite3_column_text(queryStatement, 1) else {
                    continue
                }
                let title = String(cString: titleCString)
                
                var genre = ""
                if let genreCString = sqlite3_column_text(queryStatement, 2) {
                    genre = String(cString: genreCString)
                }
                
                let releaseYear = Int(sqlite3_column_int(queryStatement, 3))
                let rating = sqlite3_column_double(queryStatement, 4)
                
                var image: UIImage? = nil
                if let blobPointer = sqlite3_column_blob(queryStatement, 5) {
                    let blobSize = Int(sqlite3_column_bytes(queryStatement, 5))
                    let blobData = Data(bytes: blobPointer, count: blobSize)
                    image = UIImage(data: blobData)
                }
                
                let movie = Movie(id: Int(id), title: title, genre: genre, releaseYear: releaseYear, rating: rating, image: image)
                movies.append(movie)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return movies
    }
    
    func deleteMovie(byID id: Int) -> Bool {
        let deleteStatementString = "DELETE FROM movies WHERE id = ?;"
        var deleteStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted movie")
                sqlite3_finalize(deleteStatement)
                return true
            } else {
                print("Failed to delete movie")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        
        sqlite3_finalize(deleteStatement)
        return false
    }
    
    deinit {
        sqlite3_close(db)
    }
}
