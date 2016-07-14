//
//  GanhuoModule.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation
import SwiftyJSON

struct GanhuoModule {
  var rawJSON: JSON = []
  
  init(rawJSON: JSON) {
    self.rawJSON = rawJSON
  }
  
  lazy var ID: String = {
    return self.rawJSON["_id"].stringValue
  }()
  
  lazy var Title: String = {
    return self.rawJSON["desc"].stringValue
  }()
  
  lazy var PublishTime: String = {
    return self.rawJSON["publishedAt"].stringValue
  }()
  
  lazy var Source: String = {
    return self.rawJSON["source"].stringValue
  }()
  
  lazy var Type: String = {
    return self.rawJSON["type"].stringValue
  }()
  
  lazy var URL: String = {
    return self.rawJSON["url"].stringValue
  }()
  
  lazy var Used: String = {
    return self.rawJSON["used"].stringValue
  }()
  
  lazy var Who: String = {
    return self.rawJSON["who"].stringValue
  }()
  
}