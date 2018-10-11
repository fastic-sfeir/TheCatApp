//
//  CATUserMessageViewController+Instances.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 03/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
extension CATUserMessageViewController {
    static func createInstace(title:String, message:String, validTitle: String) -> CATUserMessageViewController? {
        let instance =  CATUserMessageViewController(nibName: nibName, bundle: nil)
        instance.userTitle = title
        instance.userMessage = message
        instance.validTitle = validTitle
        instance.modalPresentationStyle = .overCurrentContext
//        instance.transitioningDelegate = instance
        return instance
    }
    
    static func createInstance(title:String, message:String, cancelTitle:String,  approveTitle:String, cancelAction:(() -> ())? = nil, approveAction:(() -> ())? = nil) -> CATUserMessageViewController? {
        let instance =  CATUserMessageViewController(nibName: nibName, bundle: nil)
        instance.userTitle = title
        instance.userMessage = message
        instance.approveTitle = approveTitle
        instance.cancelTitle = cancelTitle
        instance.cancelAction = cancelAction
        instance.approveAction = approveAction
        instance.modalPresentationStyle = .overCurrentContext
//        instance.transitioningDelegate = instance
        return instance
    }
}
