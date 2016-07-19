//
//  NavigationAnimator.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/19.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

class NavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  var duration = 0.3
  var operation: UINavigationControllerOperation = .Push
  var isScrollUp = true
  weak var storedContext: UIViewControllerContextTransitioning?

  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return duration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    storedContext = transitionContext
    let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
    let toVc = transitionContext.viewControllerForKey((UITransitionContextToViewControllerKey)) as! ViewController
    transitionContext.containerView()?.addSubview(toVc.view)
    toVc.view.frame.origin.y = isScrollUp ? Screen.height : -Screen.height
    UIView.animateWithDuration(duration, animations: {
      fromVc.view.frame.origin.y = self.isScrollUp ? -Screen.height : Screen.height
      toVc.view.frame.origin.y = 0
      }) { (_) in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }

  }
  
  override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    if let context = storedContext {
      context.completeTransition(!context.transitionWasCancelled())
    }
    storedContext = nil
  }
}