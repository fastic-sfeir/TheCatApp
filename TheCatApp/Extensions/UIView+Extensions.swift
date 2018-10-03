//
//  UIView+Extensions.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    static func loadNibNamed(_ name:String, forOwner: Any?) -> UIView? {
        return Bundle.main.loadNibNamed(name, owner: forOwner, options: nil)?.first as? UIView
    }
}
