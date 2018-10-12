//
//  CATMainTabBarController.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 12/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit

protocol CATReloadControllerProtocol : class {
    func reloadController()
}

class CATMainTabBarController : UITabBarController {
    
    let settings = CATDataManager.shared.settings
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepare()
    }
    
    private func prepare() {
        if let apiKey = settings.string(key: .apiKey) {
            CATDataManager.shared.httpClient.set(apiKey: apiKey, accountId: settings.string(key: .apiUserId) ?? "")
        }
        
        CATDataManager.shared.delegate = self
        CATDataManager.shared.load(completion: {
            print("done")
        })
        
        
    }
    
    private func reload() {
        if let ctrls = self.viewControllers {
            for ctrl in ctrls {
                if let reloadable = ctrl as? CATReloadControllerProtocol {
                    reloadable.reloadController()
                }
            }
        }
        
        
    }
}


extension CATMainTabBarController : CATDataManagerProtocol {
    func onSuccessfullAccount() {
        reload()
    }
    
    func favouritesUpdated() {
        
    }
    
    func votesUpdated() {
        
    }
}
