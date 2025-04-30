//
//  MovieTableViewCell.swift
//  Day2 swift
//
//  Created by Kerolos on 29/04/2025.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
               
               //imgView.layer.borderWidth = 1.0
              // imgView.layer.borderColor = UIColor.lightGray.cgColor
              
               imgView.layer.cornerRadius =  imgView.frame.size.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: Movie) {
       //   movieTitleLabel.text = movie.title
          
          if let movieImage = movie.image {
              imgView.image = movieImage
          } else {
              imgView.image = UIImage(named: "film")
          }
      }

}
