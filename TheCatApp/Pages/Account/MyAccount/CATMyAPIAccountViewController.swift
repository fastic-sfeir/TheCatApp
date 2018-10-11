//
//  CATMyAPIAccountViewController.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 04/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit

class CATMyAPIAccountViewController : UIViewController {
    
    @IBOutlet weak var viewCreateAccount: UIView!
    
    @IBOutlet weak var viewMyAccount: UIView!
    
    @IBOutlet weak var viewLoading: UIView!
    
    @IBOutlet weak var lblCreateAccount: UILabel!
    
    @IBOutlet weak var lblMyFavorites: UILabel!
    
    @IBOutlet weak var collectionFavorites: UICollectionView!
    
    let manager : CATDataManager = CATDataManager.shared
    let settings : CATSettingsManager = CATDataManager.shared.settings
    let http : CATHTTPClient = CATDataManager.shared.httpClient
    
    
    private var apiKey : String? = nil
    private var accountId : String? = nil
    
    private enum ViewStateEnum {
        case createAccount
        case loading
        case myAccount
    }
    
    
    private var viewState : ViewStateEnum = .createAccount {
        didSet {
            if viewLoading != nil {
                switch viewState {
                case .loading:
                    showViewLoading()
                    break
                case .myAccount:
                    showMyAccount()
                    break
                default:
                    showViewCreateAccount()
                    break
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepare()
    }
    
    //MARK: private
    private func prepare() {
        apiKey = settings.string(key: .apiKey)
        accountId = settings.string(key: .apiUserId)
        if let key = apiKey, let account = accountId {
            http.set(apiKey: key, accountId: account)
            viewState = .loading
            http.favorites { (favorites, error) in
                DispatchQueue.main.async {
                    if let err = error {
                        self.viewState = .createAccount
                        self.message(title: NSLocalizedString("common.title.error", comment: "common.title.error"), message: err.localizedDescription, titleAction: "OK")
                    } else {
                        self.viewState = .myAccount
                        self.manager.setApiAccount()
                        if let list = favorites {
                            self.manager.append(favorites: list)
                            self.reload()
                        }
                    }
                }
            }
        } else {
            viewState = .createAccount
        }
    }
    
    private func reload() {
        self.collectionFavorites.register(UINib(nibName: CATExtendedCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CATExtendedCollectionViewCell.reuseIdentifier)
        self.collectionFavorites.reloadData()
    }
    
    private func showViewCreateAccount() {
        viewLoading.isHidden = true
        viewMyAccount.isHidden = true
        viewCreateAccount.isHidden = false
        
        
        lblCreateAccount.text = NSLocalizedString("page.myapiaccount.createaccount", comment: "page.myapiaccount.createaccount")
    }
    
    private func showViewLoading() {
        viewLoading.isHidden = false
    }
    
    private func showMyAccount() {
        viewLoading.isHidden = true
        viewCreateAccount.isHidden = true
        viewMyAccount.isHidden = false
    }
}


extension CATMyAPIAccountViewController : CATSettingsProtocol {
    func updated() {
        prepare()
    }
}
