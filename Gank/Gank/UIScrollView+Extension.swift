//
//  UIScrollView+Extension.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/15.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

extension UIScrollView {
  var ratio: CGFloat {
    let contentHeight = self.contentSize.height
    let currentHeight = abs(self.contentOffset.y)
    return currentHeight / contentHeight
  }

  var contentHeight: CGFloat {
    return self.contentSize.height
  }
  
  var offsetY: CGFloat {
    return self.contentOffset.y
  }
  
  var isPullUpToNextPage: Bool {
    return (offsetY + Screen.height) / contentHeight > 1.1
  }
  
  var isPullDownToPreviousPage: Bool {
    return offsetY / contentHeight < -0.05
  }
}