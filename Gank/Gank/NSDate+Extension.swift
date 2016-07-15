//
//  NSDate+Extension.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/15.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation

extension NSDate {
  static func dailyApiDate() -> String{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    let date = NSDate()
    return dateFormatter.stringFromDate(date)
  }
}