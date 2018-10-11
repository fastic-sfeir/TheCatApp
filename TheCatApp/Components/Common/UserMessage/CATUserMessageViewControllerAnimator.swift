//
//  CATUserMessageViewControllerAnimator.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 04/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import UIKit

class CATUserMessageViewControllerAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    var duration : TimeInterval
    var pop : Bool = true
    init(duration:TimeInterval, pop:Bool = true) {
        self.pop = pop
        self.duration = duration
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if pop {
            popAnimated(context: transitionContext)
        } else {
            dismissAnimated(context: transitionContext)
        }
    }
    
    private func popAnimated(context:UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from)?.view,
            let to = context.viewController(forKey: .to)?.view
            else {
                return
        }
        let containerView = context.containerView
        containerView.addSubview(from)
        containerView.addSubview(to)
        to.transform = CGAffineTransform(scaleX: 0, y: 0)
        from.center = containerView.center
        to.center = containerView.center
        
        UIView.animateBy(timing: CAMediaTimingFunction(type: .ExpoOutCustom), duration: duration, animations: {
            to.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { _ in
            context.completeTransition(!context.transitionWasCancelled)
        })
    }
    
    private func dismissAnimated(context:UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from)?.view,
            let to = context.viewController(forKey: .to)?.view
            else {
                return
        }
        let containerView = context.containerView
//        containerView.addSubview(from)
//        from.center = containerView.center
//
        UIView.animateBy(timing: CAMediaTimingFunction(type: .ExpoOutCustom), duration: duration, animations: {
            from.transform = CGAffineTransform(scaleX: 0, y: 0)
        }, completion: { finished in
            from.removeFromSuperview()
            containerView.addSubview(to)
            to.frame = containerView.bounds
            to.center = containerView.center
            
            context.completeTransition(true)
        })
    }
    
    
}
