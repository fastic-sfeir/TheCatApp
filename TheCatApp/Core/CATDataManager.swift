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

class CATDataManager {
    static let shared : CATDataManager = CATDataManager()
    
    let downloader = CATDownloaderManager()
    let httpClient = CATHTTPClient()
    let settings = CATSettingsManager()
    let cache = CATImageCacheManager()
    
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
    
    
    func favorite(imageId:String) -> CATJSONFavourite? {
        return favoritesArray.filter({ (item) -> Bool in
            return item.image_id == imageId
        }).first
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
    
    func fav(imageId:String, imageUrl:String, imageData:Data, completion:@escaping ((Error?) -> ())) {
        httpClient.fav(imageId: imageId) { (err) in
            if err == nil {
                self.cache.push(imageId: imageId, imageUrl: imageUrl, imageContent: imageData)
            }
            completion(err)
        }
    }
    
    func unfav(imageId:String, completion:@escaping ((Error?) -> ())) {
        httpClient.unfav(imageId: imageId) { (err) in
            if err == nil {
                self.cache.remove(imageId: imageId)
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
