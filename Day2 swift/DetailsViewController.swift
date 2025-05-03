//
//  DetailsViewController.swift
//  Day2 swift
//
//  Created by Kerolos on 03/05/2025.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImgView: UIImageView!
    
    var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)

        getMovieDetails()

    }
    
    private func getMovieDetails() {
        guard let movie = movie else { return }
        title = movie.Title

        if let url = URL(string: movie.Poster) {
            movieImgView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
        titleLabel.text=movie.Title
        yearLabel.text = "Year: \(movie.Year)"
        ratingLabel.text = "Rated: \(movie.Rated)"
        directorLabel.text = "Director: \(movie.Director)"
        ratingLabel.text = "IMDb Rating: \(movie.imdbRating)"

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
