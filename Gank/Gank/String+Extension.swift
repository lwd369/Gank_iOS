//
//  String+Extension.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation

extension String {
  func toNSURL() -> NSURL {
    return NSURL(string: self)!
  }
}