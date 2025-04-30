//
//  AddMovieViewController.swift
//  Day2 swift
//
//  Created by Kerolos on 28/04/2025.
//
import UIKit
import PhotosUI

class AddMovieViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var ratingTf: UITextField!
    @IBOutlet weak var yearTf: UITextField!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var genreTf: UITextField!

    private var selectedImage: UIImage?
    var onMovieAdded: ((Movie) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Movie"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDonePressed))
    }
    
    @objc private func onDonePressed() {
        guard let title = titleTf.text, !title.isEmpty,
              let ratingText = ratingTf.text, !ratingText.isEmpty,
              let yearText = yearTf.text, !yearText.isEmpty,
              let genreText = genreTf.text, !genreText.isEmpty else {
            showAlert(message: "Please fill all required fields")
            return
        }
        
        guard let releaseYear = Int(yearText) else {
            showAlert(message: "Year must be a number")
            return
        }
        
        guard let rating = Double(ratingText) else {
            showAlert(message: "Rating must be a number")
            return
        }
        
        let newMovie = Movie(
            id: nil,
            title: title,
            genre: genreText,
            releaseYear: releaseYear,
            rating: rating,
            image: selectedImage
        )
        
        onMovieAdded?(newMovie)
        dismiss(animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnPickImage(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            self?.showPhotoLibraryPicker()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    private func showPhotoLibraryPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            movieImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            movieImageView.image = originalImage
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        guard let result = results.first else { return }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let image = reading as? UIImage else { return }
            
            DispatchQueue.main.async {
                self?.selectedImage = image
                self?.movieImageView.image = image
            }
        }
    }
}
