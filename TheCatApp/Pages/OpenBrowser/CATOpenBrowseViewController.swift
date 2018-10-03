//
//  CATBrowseViewController.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import UIKit

class CATOpenBrowseViewController : UIViewController {

    var images : [CATJSONImage]?
    
    var loading : Bool = false
    var itemCounter : Int = 0
    
    @IBOutlet weak var browserCollection: CATBrowserView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepare()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reload()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func prepare() {
        browserCollection.setup(dataSource: self, delegate: self, prefetch: self)
    }
    
    
    func append(items:[CATJSONImage]?) {
        
        if let actual = images, let new = items {
            for item in new {
                let f = actual.filter { (obj) -> Bool in
                    return obj.id == item.id
                }
                if f.first == nil {
                    itemCounter += 1
                    self.images?.append(item)
                }
            }
        } else if let new = items {
            images = [CATJSONImage]()
            images?.append(contentsOf: new)
            itemCounter = new.count
        }
        
        
    }
    
    func reload(all:Bool = true) {
        loading = true
        CATHTTPClient.browse(types: nil) { (results, error) in
            DispatchQueue.main.async {
                self.loading = false
                if let err = error {
                    
                } else if let list =  results {
                    if all {
                        self.append(items: list)
                        self.browserCollection.reload()
                    } else {
                        self.browserCollection.performCollectionBatch(handler: { (collection) in
                            let max = self.images?.count ?? 0
                            self.append(items: list)
                            for i in max ... self.itemCounter - 1 {
                                collection.insertItems(at: [IndexPath(item: i, section: 0)])
                            }
                        }, completion: nil)
                    }
                    
                }
            }
            
        }
    }

}
