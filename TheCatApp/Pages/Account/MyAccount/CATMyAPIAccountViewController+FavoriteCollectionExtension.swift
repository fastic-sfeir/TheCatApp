//
//  CATMyAPIAccountViewController+FavoriteCollectionExtension.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 08/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit

extension CATMyAPIAccountViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CATDataManager.shared.favorites().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CATExtendedCollectionViewCell.reuseIdentifier, for: indexPath) as! CATExtendedCollectionViewCell
        let favorite = manager.favorites()[indexPath.row]
        if let cached = manager.cache.object(forId: favorite.image_id) {
            cell.configure(fromCache: cached)
        } else {
            cell.configure(image: CATJSONImage(imageId: favorite.image_id, imageUrl: <#T##String#>))
        }
        return cell
    }
}
