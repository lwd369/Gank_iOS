//
//  DailyApi.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation

class DailyApi: NetworkApi {
  
  var requset: NSURLRequest
  var formatter: ApiDataFormatter?
  weak var delegate: NetworkDelegate?
  var day: String
  
  init(day: String, delegate: NetworkDelegate?) {
    self.day = day
    self.delegate = delegate
    
    let url = NSURL(string: "day/\(day)", relativeToURL: Network.BaseUrl)!
    requset = NSURLRequest(URL: url)
    formatter = DailyFormatter()
  }
  
}
