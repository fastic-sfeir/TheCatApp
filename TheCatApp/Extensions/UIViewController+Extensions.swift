//
//  UIViewController+Extensions.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 03/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit


//MARK: Static extensions
extension UIViewController {
    static func loadFromStoryBoard<T>(identifier:String) -> T? {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier) as? T
    }
}


//MARK: Instance extensions
extension UIViewController {
    func message(title:String, message:String, titleAction:String) {
        
        if let ctrl = CATUserMessageViewController.createInstace(title: title, message: message, validTitle: titleAction) {
            self.definesPresentationContext = true
            self.present(ctrl, animated: true, completion: nil)
        }
    }
    
    func ask(title:String, message:String, cancel:String, approve:String, approveAction:(() -> ())? = nil, cancelAction:(() -> ())? = nil) {
        if let ctrl = CATUserMessageViewController.createInstance(title: title, message: message, cancelTitle: cancel, approveTitle: approve, cancelAction: cancelAction, approveAction: approveAction) {
            self.definesPresentationContext = true
            self.present(ctrl, animated: true, completion: nil)
        }
    }
}
