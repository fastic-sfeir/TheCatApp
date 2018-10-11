//
//  CATBaseCollectionCellCollectionViewCell.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import UIKit
import FLAnimatedImage

class CATBaseCollectionCellCollectionViewCell: UICollectionViewCell {

    static let nibName : String = "CATBaseCollectionCellCollectionViewCell"
    static let reuseIdentifier : String = "baseCatCellReusableIdentifier"
    static let cellHeight : CGFloat = 160.0

    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var imageContent: FLAnimatedImageView!

    var catImage : CATJSONImage?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.render()
    }

    func configure(image : CATJSONImage?) {
        self.catImage = image
        self.render()
    }

    private func render() {
        if let obj = self.catImage {
            imageContent.image = nil
            loadingView.isHidden = false
            
            imageContent.render(url: obj.url) {
                self.loadingView.isHidden = true
            }
            
//            CATHTTPClient.image(url: obj.url) { (image, err) in
//                DispatchQueue.main.async {
//                    self.loadingView.isHidden = true
//                    if let animated = image as? FLAnimatedImage {
//                        self.imageContent.animatedImage = animated
//                    } else if let cached = image as? UIImage {
//                        self.imageContent.image = cached
//                    }
//                }
//            }
        } else {
            loadingView.isHidden = false
        }
    }
}
