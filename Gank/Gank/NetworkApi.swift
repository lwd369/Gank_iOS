//
//  NetworkApi.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NetworkApi {
  var requset: NSURLRequest { get set }
  var formatter: ApiDataFormatter { get set }
  var delegate: NetworkDelegate? { get set }
}

extension NetworkApi {
  
  var config: NSURLSessionConfiguration {
    return NSURLSessionConfiguration.defaultSessionConfiguration()
  }
  
  var session: NSURLSession {
    return NSURLSession(configuration: config)
  }
  
  func startRequest() {
    let task = session.dataTaskWithRequest(requset) {
      data, response, error in
      guard let data = data else { return }
      NSOperationQueue.mainQueue().addOperationWithBlock({
        let json = JSON(data: data)
        if let result = self.formatter.formatData(json) {
          self.delegate?.didReceiveApiData(result)
        }
      })
    }
    task.resume()
  }
}

protocol NetworkDelegate {
  func didReceiveApiData(data: ViewModule)
  func receiveWithError()
}


protocol ViewModule {
  
}


protocol ApiDataFormatter {
  func formatData(data: JSON) -> ViewModule?
}



