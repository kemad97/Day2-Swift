//
//  MovieDetailsViewController.swift
//  Day2 swift
//
//  Created by Kerolos on 27/04/2025.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_rating: UILabel!
    @IBOutlet weak var label_release: UILabel!
    @IBOutlet weak var label_genre: UILabel!
    
    @IBOutlet weak var filmImg: UIImageView!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = movie
        else {
            return
            
        }
        label_title.text = "Title: \(movie.title)"
        label_rating.text = "Rating: \(movie.rating)"
        label_release.text = "Release Year: \(movie.releaseYear)"
        label_genre.text = "Genre: \(movie.genre) "
        filmImg.image = UIImage(named: "film")
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
