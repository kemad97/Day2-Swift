//
//  AddMovieViewController.swift
//  Day2 swift
//
//  Created by Kerolos on 28/04/2025.
//

import UIKit

class AddMovieViewController: UIViewController {
    @IBOutlet weak var titleTf: UITextField!
    
    @IBOutlet weak var ratingTf: UITextField!
    
    @IBOutlet weak var yearTf: UITextField!
    
    @IBOutlet weak var genreTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add Movie"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDonePressed))

    }
    
    var onMovieAdded: ((Movie) -> Void)?

    
    @objc private func  onDonePressed() {
        guard let title = titleTf.text , !title.isEmpty,
        let ratingText = ratingTf.text, let rating=Float(ratingText),
        let yearText=yearTf.text,  let year=Int(yearText),
        let genreText=genreTf.text, !genreText.isEmpty
        
        else {
            showAlert(message: "Please fill all  ")
            return
        }
        let genres=genreText.components(separatedBy: ",")
        
        let newMovie = Movie(title: title, rating: rating, releaseYear: year, genre: genres)
        
        onMovieAdded?(newMovie)
        
        dismiss(animated: true, completion: nil)


        
    }
    
    private func showAlert(message: String) {
           let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
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
