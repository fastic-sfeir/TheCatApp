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
    
    static func undownloadableURL() -> Error {
        return NSError(domain: CATAppEnv.bundleIdentifier(), code: -42000, userInfo: [NSLocalizedDescriptionKey : ""]) as Error
    }
    static func malformedURLError() -> Error {
        return NSError(domain: CATAppEnv.bundleIdentifier(), code: -42001, userInfo: [NSLocalizedDescriptionKey : ""]) as Error
    }
    
    static func malformedJSONError() -> Error {
        return NSError(domain: CATAppEnv.bundleIdentifier(), code: -42003, userInfo: [NSLocalizedDescriptionKey : ""])
    }
}
