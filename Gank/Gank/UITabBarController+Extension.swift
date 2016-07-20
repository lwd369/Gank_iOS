//
//  UITabBarController+Extension.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/20.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

extension UITabBarController {
  public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    if let selected = selectedViewController {
      return selected.supportedInterfaceOrientations()
    }
    return super.supportedInterfaceOrientations()
  }
  
  public override func shouldAutorotate() -> Bool {
    if let selected = selectedViewController {
      return selected.shouldAutorotate()
    }
    return super.shouldAutorotate()
  }
}
