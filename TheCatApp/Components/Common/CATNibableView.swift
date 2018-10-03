//
//  CATNibableView.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//
import Foundation
import UIKit

class CATNibableView : UIView {
    private weak var contentView : UIView!
    
    func commonInit(nibName:String) {
        guard let view = UIView.loadNibNamed(nibName, forOwner: self) else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView = view
        if let v = contentView {
            addSubview(v)
        }
        
    }
}
