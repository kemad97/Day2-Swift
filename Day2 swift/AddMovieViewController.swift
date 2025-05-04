//
//  AddMovieViewController.swift
//  Day2 swift
//
//  Created by Kerolos on 04/05/2025.
//

import UIKit

class AddMovieViewController: UIViewController {

    @IBOutlet weak var posterTF: UITextField!
    @IBOutlet weak var directorTF: UITextField!
    @IBOutlet weak var ratingTF: UITextField!
    @IBOutlet weak var yearTf: UITextField!
    @IBOutlet weak var titleTf: UITextField!
    
    var onMovieAdded: ((Movie) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title="Add New Movie"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done, target: self, action: #selector(OnDonePressed)
        )
    }
    
    @objc func OnDonePressed (){
        let newMovie = Movie(
                    Title: titleTf.text ?? "",
                    Year: yearTf.text ?? "",
                    Rated: ratingTF.text ?? "Not Rated",
                    Director: directorTF.text ?? "Unknown",
                    Poster: posterTF.text ?? "",
                    imdbRating: ratingTF.text ?? "0.0"
                )
                
        
        onMovieAdded?(newMovie)
        dismiss(animated: true)
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
