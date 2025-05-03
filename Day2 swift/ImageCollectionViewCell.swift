//
//  ImageCollectionViewCell.swift
//  Day2 swift
//
//  Created by Kerolos on 29/04/2025.
//

import UIKit
import SkeletonView  // For shimmer effect

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var customImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customImgView.isSkeletonable = true
        customImgView.skeletonCornerRadius = 8  // Optional: Rounded corners()
    }
    
    
    func startShimmer() {
        customImgView.showAnimatedGradientSkeleton()
    }
    
    func stopShimmer() {
        customImgView.hideSkeleton()
    }
}
