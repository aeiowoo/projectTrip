//
//  ModalAnimator.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 9..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class ModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let duration : TimeInterval = 1
    var isPresenting = true
    let destFrame = CGPoint.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let menuView = isPresenting ? toView :
            transitionContext.view(forKey: .from)!
        
        let originPoint = CGPoint(x: 0 - toView.frame.size.width, y: 0)
        
        menuView.frame.origin = self.isPresenting ? originPoint : self.destFrame
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: menuView)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, animations: {
            
            menuView.frame.origin = self.isPresenting ? self.destFrame : originPoint
            
        }, completion: { _ in
            
            transitionContext.completeTransition(true)
        })
        
    }
}




















