//
//  Array+Extensions.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation

extension Array {
    func concat(separator:String) -> String {
        var value : String = ""
        if self.count > 0 {
            for item in self {
                if value == "" {
                    value = String(describing: item)
                } else {
                    value = String(format:"%@%@", separator, String(describing: item))
                }
            }
        }
        return value
    }
}
