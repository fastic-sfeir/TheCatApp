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
    
    init() {
        
    }
    
}
