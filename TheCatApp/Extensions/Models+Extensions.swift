//
//  Models+Extensions.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 10/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
extension CATImageCached {
    func toJSONImage() -> CATJSONImage {
        return CATJSONImage(imageId:self.id, imageUrl:self.url)
    }
}

