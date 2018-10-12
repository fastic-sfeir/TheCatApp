//
//  CATBrowseViewController+CollectionView.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit

extension CATOpenBrowseViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    
    //UICollectionViewDataSourcePrefetching
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        print("DEBUG:collectionView prefetch items : \(indexPaths)")
    }
    
    
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images?.count ?? 0
        return itemCounter
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: browserCollection.cellIdentifier, for: indexPath)
        let obj = images?[indexPath.row]
        if useExtendedCell {
            let extended = cell as! CATExtendedCollectionViewCell
            extended.configure(image: obj)
            return extended
        } else {
            let basic = cell as! CATBaseCollectionCellCollectionViewCell
            basic.configure(image: obj)
            return basic
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //infinite scroll
        if !loading, indexPath.row > (itemCounter - 5) {
            self.reload(all: false)
        }
    }
    
    //UICollectionViewDelegate
    
    
    
    
    
    //UICollectionViewDelegateFlowLayout
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let insets = collectionView.contentInset.left + collectionView.contentInset.right
//        
//        let w = (collectionView.bounds.width + 40) / 2
//        
//        return CGSize(width: w, height: CATBaseCollectionCellCollectionViewCell.cellHeight)
//    }
    
    
    
}
