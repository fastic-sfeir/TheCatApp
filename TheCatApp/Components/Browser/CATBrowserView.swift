//
//  CATBrowserView.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import UIKit

class CATBrowserView: CATNibableView {
    static let nibName : String = "CATBrowserView"


    
    @IBOutlet weak var imagesCollection: UICollectionView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.commonInit(nibName: CATBrowserView.nibName)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.commonInit(nibName: CATBrowserView.nibName)
        customInit()
    }
    
    private func customInit() {
        imagesCollection.register(UINib(nibName: CATBaseCollectionCellCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CATBaseCollectionCellCollectionViewCell.reuseIdentifier)
        
    }
    
    func setup(dataSource:UICollectionViewDataSource, delegate:UICollectionViewDelegate, prefetch:UICollectionViewDataSourcePrefetching) {
        imagesCollection.dataSource = dataSource
        imagesCollection.delegate = delegate
        imagesCollection.prefetchDataSource = prefetch
        reload()
    }
    
    
    
    func reload() {
        imagesCollection.reloadData()
    }
    func performCollectionBatch(handler:@escaping (UICollectionView) -> (), completion:((Bool) -> ())? = nil) {
        imagesCollection.performBatchUpdates({
            handler(imagesCollection)
        }) { (finished) in
            if let comp = completion {
                comp(finished)
            }
        }
    }
    func insert(indexes:[IndexPath]) {
        imagesCollection.insertItems(at: indexes)
    }
}
