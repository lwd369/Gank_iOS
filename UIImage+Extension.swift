//
//  UIImage+Extension.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/15.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

extension UIImage {
  func ratio() -> CGFloat {
    return self.size.width / self.size.height
  }
  
  var constrainHeight: CGFloat {
    return Screen.width / self.ratio()
  }
}