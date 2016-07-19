//
//  Constants.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

struct Network {
  
  static let BaseApi = "http://gank.io/api/"
  static let BaseUrl = NSURL(string: Network.BaseApi)
  
}

struct Screen {
  static let width = UIScreen.mainScreen().bounds.width
  static let height = UIScreen.mainScreen().bounds.height
  static let navBarHeight = CGFloat(64.0)
  static let tabBarHeight = CGFloat(49.0)
  static let contentHeight = Screen.height - Screen.navBarHeight - Screen.tabBarHeight
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