//
//  DissmissAnimator.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/19.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  var duration = 1.0
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return duration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let containView = transitionContext.containerView()!
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    
    containView.insertSubview(toView, belowSubview: fromView)
    
    UIView.animateWithDuration(duration, animations: {
      fromView.frame.origin.y = -Screen.height
      fromView.alpha = 0.0
    }) { (_) in
      transitionContext.completeTransition(true)
    }
    
  }
}
