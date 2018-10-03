//
//  CATAppEnv.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation


class CATAppEnv {    
    static func bundleIdentifier() -> String {
        return Bundle.main.bundleIdentifier ?? "com.error.app"
    }
}
