//
//  CATExtendedCollectionViewCell.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 10/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import UIKit
import FLAnimatedImage

class CATExtendedCollectionViewCell: UICollectionViewCell {

    static let nibName : String = "CATExtendedCollectionViewCell"
    static let reuseIdentifier : String = "CATExtendedCollectionViewCellReusableIdentifier"
    
    
    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBOutlet weak var imageContent: FLAnimatedImageView!
    
    var currentImage : CATJSONImage?
    var isFavorite : Bool = false {
        didSet {
            if btnFavorite != nil {
                btnFavorite.isHighlighted = isFavorite
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func prepare(withImageId:String) {
        self.isFavorite = CATDataManager.shared.favorite(imageId: withImageId) != nil
    }

    func configure(image:CATJSONImage?) {
        self.currentImage = image
        if let current = currentImage {
            prepare(withImageId: current.id)
            imageContent.render(url: current.url, completion: nil)            
        }
    }
    
    func configure(fromCache:CATImageCached) {
        if let filepath = CATDataManager.shared.cache.filepath(forUrl: fromCache.url) {
            let url = URL(fileURLWithPath: filepath)
            if url.lastPathComponent == "gif", let data = try? Data(contentsOf: url) {
                imageContent.animatedImage = FLAnimatedImage(animatedGIFData: data)
            } else {
                imageContent.image = UIImage(contentsOfFile: filepath)
            }
        }
    }
    
    
    
    @IBAction func onFavOrUnfav(_ sender: UIButton) {
        
    }
    
    @IBAction func onPlusVote(_ sender: UIButton) {
    }
    
    @IBAction func onMinusVote(_ sender: UIButton) {
        
    }
}
