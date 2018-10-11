//
//  CATJSONFavourite.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 04/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
//"created_at": "2018-10-02T12:58:19.000Z"
struct CATJSONFavourite : Codable {
    var id : Int32
    var user_id : String
    var image_id : String
    var sub_id : String
    var created_at : String
}

