//
//  UIImage+Extensions.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit
import FLAnimatedImage

extension FLAnimatedImageView {
    func render(url:String, completion:(() -> ())? = nil) {
        CATHTTPClient.image(url: url) { (image, err) in
            
            if let animated = image as? FLAnimatedImage {
                self.animatedImage = animated
            } else if let normal = image as? UIImage {
                self.image = normal
            } else {
                self.image = nil
            }
            completion?()
        }
    }
}


