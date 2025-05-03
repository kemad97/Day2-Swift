//
//  ImageCollectionViewController.swift
//  Day2 swift
//
//  Created by Kerolos on 29/04/2025.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout
{
    
    private let reuseIdentifier = "Cell"
    private var movies: [Movie] = []
    private let apiUrl = "https://dummyjson.com/c/8b9b-3f93-4c8d-a8b9"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovies()
    }

    
    func fetchMovies() {
           guard let url = URL(string: apiUrl) else {
               print("Invalid URL")
               return
           }
           
           let request = URLRequest(url: url)
           let session = URLSession(configuration: .default)
           
           let task = session.dataTask(with: request) { [weak self] (data, response, error) in
               guard let self = self
               else { return }
               
               
               
               if let data = data {
                   do {
                       self.movies = try JSONDecoder().decode([Movie].self, from: data)
                       
                       DispatchQueue.main.async {
                           self.collectionView.reloadData()
                       }
                   } catch {
                       print("Error decoding JSON: \(error)")
                   }
               }
           }
           task.resume()
       }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        let movie = movies [indexPath.row]
        
        // Start shimmer effect immediately
           cell.startShimmer()
           cell.customImgView.image = nil // Clear previous image
        

        
        guard let url = URL(string: movie.Poster)
        
        else {
               cell.stopShimmer()
               cell.customImgView.image = UIImage(named: "notfound") // Fallback image
               return cell
           }
        
        cell.customImgView.kf.setImage(
                with: url,
                completionHandler: { result in
                    cell.stopShimmer() // Stop shimmer when done (success or failure)
                    
                    switch result {
                    case .success(_):
                        break // Image loaded successfully
                    case .failure(_):
                        cell.stopShimmer()
                        cell.customImgView.image = UIImage(named: "notfound") // Error fallback
                    }
                }
            )
            
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailsId") as? DetailsViewController
        else {
            return
        }
        
        detailVC.movie=selectedMovie
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
