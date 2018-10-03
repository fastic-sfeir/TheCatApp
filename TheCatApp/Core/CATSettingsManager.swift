//
//  CATSettingsManager.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation


protocol CATSettingsProtocol : class {
    func updated()
}

class CATSettingsManager {
    weak var delegate : CATSettingsProtocol?
    
    enum CATSettingKey : String {
        case apiUserId = "APIUserId"
        case apiKey = "APIKey"
    }
    
    private func commonInit() {
        let appDefaults : [String:AnyObject] = [ CATSettingKey.apiUserId.rawValue : "" as AnyObject, CATSettingKey.apiKey.rawValue : "" as AnyObject]
        UserDefaults.standard.register(defaults: appDefaults)
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateSettings(_:)), name: UserDefaults.didChangeNotification, object: nil)
        
    }
    @objc private func didUpdateSettings(_ notification: Notification) {
        delegate?.updated()
    }
    private func unleash() {
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        unleash()
    }
   
    
    func load() {
        commonInit()
        
    }
    
    func bool(key:CATSettingKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    func string(key:CATSettingKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    func int(key:CATSettingKey)->Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    func double(key:CATSettingKey) -> Double {
        return UserDefaults.standard.double(forKey: key.rawValue)
    }
    
    func write(value:Any?, to:CATSettingKey) {
        UserDefaults.standard.set(value, forKey: to.rawValue)
    }
    
    func register(owner:CATSettingsProtocol) {
        self.delegate = owner
    }
    
}
