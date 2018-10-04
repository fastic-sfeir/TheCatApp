//
//  UIView+Extensions.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit


//MARK: Static funcs
extension UIView {
    static func loadNibNamed(_ name:String, forOwner: Any?) -> UIView? {
        return Bundle.main.loadNibNamed(name, owner: forOwner, options: nil)?.first as? UIView
    }
    
    static func animateBy(timing:CAMediaTimingFunction, duration:Double, animations:@escaping () -> Void, completion:((Bool) -> ())? = nil) {
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timing)
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
        CATransaction.commit()
    }
}
