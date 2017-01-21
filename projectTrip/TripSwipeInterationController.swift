//
//  TripSwipeInterationController.swift
//  projectTrip
//
//  Created by Friday on 2017. 1. 2..
//  Copyright © 2017년 SwiftTive. All rights reserved.
//

import UIKit

class TripSwipeInterationController: UIPercentDrivenInteractiveTransition {

    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(view: viewController.view)
        print("wire")
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(gestureRecognizer:)))
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(handleGesture(gestureRecognizer:)))
        
        gesture.edges = UIRectEdge.right
        gesture1.numberOfTapsRequired = 1
        gesture1.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        // 1
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        
//        var progress = (translation.x / 200)
//        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        var progress = -(gestureRecognizer.translation(in: gestureRecognizer.view!).x / (gestureRecognizer.view!.bounds.size.width*3))
        progress = min(1.0, max(0.0, progress))
        
        switch gestureRecognizer.state {
        
        case .began:
            // 2
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            // 3
            shouldCompleteTransition = progress > 0.1
            
            print(progress)
//            print("start")
            update(progress)
            
        case .cancelled:
            // 4
            interactionInProgress = false
            cancel()
            
        case .ended:
            // 5
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                cancel()
            } else {
                
                finish()
                
            }
            
        default:
            print("Unsupported")
        }
    }
}
