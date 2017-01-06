//
//  TripDismissModalAnimator.swift
//  projectTrip
//
//  Created by Friday on 2017. 1. 2..
//  Copyright © 2017년 SwiftTive. All rights reserved.
//

import UIKit

class TripDismissModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let duration : TimeInterval = 0.7
    var isPresenting = false
    let destFrame = CGPoint.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        
        let originPoint = CGPoint(x: 0 - fromView.frame.size.width, y: 0)
        
        fromView.frame.origin = self.isPresenting ? originPoint : self.destFrame
        
        containerView.addSubview(fromView)
        //        containerView.bringSubview(toFront: menuView)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, animations: {
            
            fromView.frame.origin = self.isPresenting ? self.destFrame : originPoint
            
        }, completion: { _ in
            
            transitionContext.completeTransition(true)
            
        })
        
    }
}
















