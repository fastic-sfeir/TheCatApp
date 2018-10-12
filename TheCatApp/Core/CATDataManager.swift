//
//  CATDataManager.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import Alamofire
import FLAnimatedImage

protocol CATDataManagerProtocol : class {
    func onSuccessfullAccount()
    func favouritesUpdated()
    func votesUpdated()
}



class CATDataManager {
    static let shared : CATDataManager = CATDataManager()
    
    let downloader = CATDownloaderManager()
    let httpClient = CATHTTPClient()
    let settings = CATSettingsManager()
    let cache = CATImageCacheManager()
    weak var delegate : CATDataManagerProtocol? = nil
    private var favoritesArray : [CATJSONFavourite] = [CATJSONFavourite]()
    private var votesArray : [Any]? = nil
    
    private var haveAPIAccount : Bool = false
    
    init() {
        commonInit()
    }
    
    
    //MARK : private
    private func commonInit() {
        cache.load()
    }
    
    
    func load(completion:@escaping (() -> ()?)) {
        httpClient.favorites { (favorites, err) in
            if let list = favorites {
                self.append(favorites: list)
            }
            if err == nil {
                self.setApiAccount(haveIt: true)
                self.delegate?.onSuccessfullAccount()
            }
            completion()
        }
    }
    
    
    func setApiAccount(haveIt:Bool = true) {
        haveAPIAccount = haveIt
    }
    func haveAccount() -> Bool {
        return haveAPIAccount
    }
    
    func favorites() -> [CATJSONFavourite] {
        return favoritesArray
    }
    
    
    func favorite(imageId:String) -> CATJSONFavourite? {
        return favoritesArray.filter({ (item) -> Bool in
            return item.image_id == imageId
        }).first
    }
    
    
    func fav(imageId:String, imageUrl:String, imageData:Data, completion:@escaping ((Error?) -> ())) {
        httpClient.fav(imageId: imageId) { (err) in
            if err == nil {
                self.cache.push(imageId: imageId, imageUrl: imageUrl, imageContent: imageData)
                self.delegate?.favouritesUpdated()
            }
            completion(err)
        }
    }
    
    func unfav(imageId:String, completion:@escaping ((Error?) -> ())) {
        httpClient.unfav(imageId: imageId) { (err) in
            if err == nil {
                self.cache.remove(imageId: imageId)
                self.delegate?.favouritesUpdated()
            }
            completion(err)
        }
    }

    func append(favorites:[CATJSONFavourite]) {
        for item in favorites {
            let found = favorite(imageId: item.image_id)
            if found == nil {
                favoritesArray.append(item)
            }
        }
    }
    
    func votes() -> [Any]? {
        return nil
    }
}
