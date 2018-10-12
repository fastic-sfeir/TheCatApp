//
//  CATBrowserView.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import UIKit

@objc protocol CATBrowserRefreshProtocol : class {
    func refreshed()
}
class CATBrowserView: CATNibableView {
    static let nibName : String = "CATBrowserView"

    let refreshControl = UIRefreshControl()
    weak var refrehDelegate : CATBrowserRefreshProtocol?
    @IBOutlet weak var imagesCollection: UICollectionView!

    var useExtendedCell : Bool = false
    var cellIdentifier : String = CATBaseCollectionCellCollectionViewCell.reuseIdentifier
    
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
        refreshControl.addTarget(self, action: #selector(onPullRefreshed(sender:)), for: .valueChanged)
        imagesCollection.refreshControl = refreshControl
    }
    
    func setup(dataSource:UICollectionViewDataSource, delegate:UICollectionViewDelegate, prefetch:UICollectionViewDataSourcePrefetching, useExtended: Bool = false) {
        imagesCollection.dataSource = dataSource
        imagesCollection.delegate = delegate
        imagesCollection.prefetchDataSource = prefetch
        useExtendedCell = useExtended
        let nib = UINib(nibName: useExtendedCell ? CATExtendedCollectionViewCell.nibName : CATBaseCollectionCellCollectionViewCell.nibName, bundle: nil)
        cellIdentifier = useExtendedCell ? CATExtendedCollectionViewCell.reuseIdentifier : CATBaseCollectionCellCollectionViewCell.reuseIdentifier
        imagesCollection.register(nib, forCellWithReuseIdentifier: cellIdentifier)
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
    
    @objc func onPullRefreshed(sender:Any?) {
        refrehDelegate?.refreshed()
    }
}
