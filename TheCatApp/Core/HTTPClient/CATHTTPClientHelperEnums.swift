//
//  CATHTTPClientBrowseOptions.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation

enum CATHTTPClientOptionMimeType {
    case PNG
    case GIF
    case JPG
}

class CATHTTPErrorHelper {
    
    enum CATErrorEnum : Int {
        
        case malformedUrl = -42000
        case noInformation = -42001
        case unknowUrl = -42002
        case malformedJSON = -42003
        case badInformation = -42004
        
    }
    
    
    static func undownloadableURL() -> Error {
        return NSError(domain: CATAppEnv.bundleIdentifier(), code: CATErrorEnum.unknowUrl.rawValue, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("common.error.message.unknowurl", comment: "common.error.message.unknowurl")]) as Error
    }
    static func malformedURLError() -> Error {
        return NSError(domain: CATAppEnv.bundleIdentifier(), code: CATErrorEnum.malformedUrl.rawValue, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("common.error.message.malformedurl", comment: "common.error.message.malformedurl")]) as Error
    }
    
    static func malformedJSONError() -> Error {
        return NSError(domain: CATAppEnv.bundleIdentifier(), code: CATErrorEnum.malformedJSON.rawValue, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("common.error.message.malformedjson", comment: "common.error.message.malformedjson")])
    }
    
    static func noAccountInformation() -> Error {
        return NSError(domain: CATAppEnv.bundleIdentifier(), code: CATErrorEnum.noInformation.rawValue, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("common.error.message.noaccountinformation", comment: "common.error.message.noaccountinformation")])
    }
    static func badAccountInformation() -> Error {
        return NSError(domain: CATAppEnv.bundleIdentifier(), code: CATErrorEnum.badInformation.rawValue, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("common.error.message.badaccountinformation", comment: "common.error.message.badaccountinformation")])
    }
    
    
    
}
