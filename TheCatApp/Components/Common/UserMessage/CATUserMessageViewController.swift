//
//  CATUserMessageViewController.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 03/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import UIKit

class CATUserMessageViewController: UIViewController {

    static let nibName : String = "CATUserMessageViewController"
    
    var userTitle : String?
    var userMessage : String?
    
    var validTitle : String?
    var cancelTitle : String?
    var approveTitle : String?
    
    var cancelAction : (() -> ())? = nil
    var approveAction : (() -> ())? = nil
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var viewContainerValid: UIView!
    @IBOutlet weak var btnValid: UIButton!
    
    
    @IBOutlet weak var viewContainerApprove: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnApprove: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.transitioningDelegate = self
        // Do any additional setup after loading the view.
        prepare()
    }


    //MARK: Private
    private func prepare() {
        lblTitle.text = userTitle
        lblMessage.text = userMessage
        if let simpleAction = validTitle {
            viewContainerValid.isHidden = false
            viewContainerApprove.isHidden = true
            btnValid.setTitle(simpleAction, for: .normal)
        } else {
            viewContainerValid.isHidden = true
            viewContainerApprove.isHidden = false
            btnCancel.setTitle(cancelTitle ?? "", for: .normal)
            btnApprove.setTitle(approveTitle ?? "", for: .normal)
        }
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    @IBAction func onValid(_ sender: UIButton) {
        dismiss()
    }
    
    @IBAction func onCancel(_ sender: UIButton) {
        if let v = cancelAction {
            v()
        }
        dismiss()
    }
    
    @IBAction func onApprove(_ sender: UIButton) {
        if let v = approveAction {
            v()
        }
        dismiss()
    }
}


extension CATUserMessageViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CATUserMessageViewControllerAnimator(duration: 0.35)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CATUserMessageViewControllerAnimator(duration: 0.35, pop: false)
    }
    
}
