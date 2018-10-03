//
//  UIImage+Extensions.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit

enum UIImageType {
    case normal
    case animated
}

extension UIImage {
    func type() -> UIImageType {
        
        
        return .normal
    }
}
