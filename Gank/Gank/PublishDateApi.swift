//
//  PublishDateApi.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/18.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation
import SwiftyJSON

class PublishDateApi: NetworkApi {
  var requset: NSURLRequest
  var formatter: ApiDataFormatter?
  weak var delegate: NetworkDelegate?
  private var dates = [String]()
  var apiCompleted: (([String]) -> Void)?
  
  init() {
    let url = NSURL(string: "day/history", relativeToURL: Network.BaseUrl)
    self.requset = NSURLRequest(URL: url!)
    self.delegate = self
  }
}

extension PublishDateApi: NetworkDelegate {
  
  func didReceiveApiJson(json: JSON) {
    for (_, subJson) in json["results"] {
      let date = subJson.stringValue
      let resultDate = date.stringByReplacingOccurrencesOfString("-", withString: "/")
      dates.append(resultDate)
    }
    if let apiCompleted = apiCompleted {
      apiCompleted(self.dates)
    }
  }
  
  func receiveWithError() {
    
  }
}
