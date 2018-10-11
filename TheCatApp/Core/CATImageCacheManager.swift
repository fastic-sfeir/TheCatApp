//
//  CATImageCacheManager.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 08/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation


struct CATCacheWrapper : Codable {
    var items : [ String  : CATImageCached]
}

struct CATImageCached : Codable {
    var id : String
    var url : String
    var relativeUrl : String
}


class CATImageCacheManager {
    
    
    private static let CachePathJSON : String = "url-cached.json"
    private static let CachePathName : String = "Cached"
    
    private var cached : [String : CATImageCached] = [String : CATImageCached]()
    
    init() {
        load()
    }
    
    private static func cachePath() -> URL? {
        if let container = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let cachedContainer = container.appendingPathComponent(CATImageCacheManager.CachePathName, isDirectory: true)
            try? FileManager.default.createDirectory(at: cachedContainer, withIntermediateDirectories: false, attributes: nil)
            return cachedContainer
        }
        return nil
    }
    
    
    func load() {
        if let root = CATImageCacheManager.cachePath() {
            let filepath = root.appendingPathComponent(CATImageCacheManager.CachePathJSON)
            if let data = try? Data(contentsOf: filepath), let decoded = try?  JSONDecoder().decode(CATCacheWrapper.self, from: data) as CATCacheWrapper {
                self.cached = decoded.items
            }
        }
    }
    
    private func sync() {
        
        if let root = CATImageCacheManager.cachePath() {
            let filepath = root.appendingPathComponent(CATImageCacheManager.CachePathJSON)
            if let encoded = try? JSONEncoder().encode(CATCacheWrapper(items: cached)) {
                try? encoded.write(to: filepath)
            }
        }
    }
    
    
    func push(imageId:String, imageUrl:String, imageContent:Data) {
        if let root = CATImageCacheManager.cachePath(), let url = URL(string: imageUrl) {
            let filepath = root.appendingPathComponent(url.lastPathComponent)
            try? imageContent.write(to: filepath)
            let cachedObject = CATImageCached(id: imageId, url: imageUrl, relativeUrl: url.lastPathComponent)
            cached[cachedObject.id] = cachedObject
            sync()
        }
    }
    
    func remove(imageId:String) {
        cached.removeValue(forKey: imageId)
    }
    
    func object(forId imageId:String) -> CATImageCached? {
        return cached[imageId]
    }
    
    func filepath(forUrl url:String) -> String? {
        if let root = CATImageCacheManager.cachePath(), let parsedUrl = URL(string: url) {
            return root.appendingPathComponent(parsedUrl.lastPathComponent).path
        }
        return nil
    }
    
    
    
    
}
