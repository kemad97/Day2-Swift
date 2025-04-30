//
//  MoviesTableViewController.swift
//  Day2 swift
//
//  Created by Kerolos on 27/04/2025.
//

import UIKit

struct Movie {
    let title: String
    let rating: Float
    let releaseYear: Int
    let genre: [String]
    let image: UIImage?
    
}


class MoviesTableViewController: UITableViewController {
    
    
    private var movies: [Movie] = [
//           Movie(title: "Film 1", rating: 7, releaseYear: 2000, genre: ["Action],[Drama" ]) ,
//           Movie(title: "Film 2", rating: 8, releaseYear: 2000, genre:  ["Action],[Drama" ]),
//           Movie(title: "Film 3", rating: 9, releaseYear: 2000, genre: ["Action],[Drama" ]),
//           Movie(title: "Film 4",  rating: 8, releaseYear: 2000, genre: ["Action],[Drama" ]),
//           Movie(title: "Film 5", rating: 7, releaseYear: 2000, genre: ["Action],[Drama" ] )
       ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MoviesId")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed))

    }

    @objc func addBtnPressed() {
            guard let addMovieVC = self.storyboard?.instantiateViewController(withIdentifier: "AddMovieId") as? AddMovieViewController else {
                
                return
            }
        
        addMovieVC.onMovieAdded={[weak self]
            newMovie in self?.movies.append(newMovie)
            self?.tableView.reloadData()
        }
            let navController = UINavigationController(rootViewController: addMovieVC)
            present(navController, animated: true, completion: nil)
        }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        
           let movie = movies[indexPath.row]
        
           cell.textLabel?.text = movie.title
        cell.configure(with: movie)

        
           return cell
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let selectedMovie = movies[indexPath.row]
            
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsId") as? MovieDetailsViewController else {
                return
            }
            
            detailVC.movie = selectedMovie
            
            navigationController?.pushViewController(detailVC, animated: true)
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
