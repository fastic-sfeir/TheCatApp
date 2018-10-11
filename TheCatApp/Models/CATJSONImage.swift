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
    var width : Int64? = nil
    var height : Int64? = nil
    var mimeType : String? = nil
//    var breeds : [Any]?
    var categories : [CATJSONCategory]? = nil
    init(imageId:String, imageUrl:String) {
        self.id = imageId
        self.url = imageUrl
    }
}


