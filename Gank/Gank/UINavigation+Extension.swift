//
//  UINavigation+Extension.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/15.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

extension UINavigationController {
  func setStatusAndNavBarHidden(ratio: CGFloat) {
    if ratio < 0.3 {
      self.setNavigationBarHidden(false, animated: true)
      UIApplication.sharedApplication().statusBarHidden = false
    } else {
      self.setNavigationBarHidden(true, animated: true)
      UIApplication.sharedApplication().statusBarHidden = true
    }
  }
}