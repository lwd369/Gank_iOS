//
//  Constants.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation

struct Network {
  
  static let BaseApi = "http://gank.io/api/"
  static let BaseUrl = NSURL(string: Network.BaseApi)
  
}


enum GanhuoType: String {
  case ios      = "iOS"
  case android  = "Android"
  case app      = "App"
  case other    = "瞎推荐"
  case welfare  = "福利"
  case video    = "休息视频"
  case expend   = "拓展资源"
}