//
//  CATJSONImage.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 28/09/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation


struct CATJSONImage : Codable {
    var id : String
    var url : String
    var width : Int64?
    var height : Int64?
    var mimeType : String?
//    var breeds : [Any]?
    var categories : [CATJSONCategory]?

}
