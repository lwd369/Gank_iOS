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
  var formatter: ApiDataFormatter? { get set } // 在处理给view提供数据的接口时提供，格式化数据为viewModule
  var delegate: NetworkDelegate? { get set }
}

extension NetworkApi {
  
  var config: NSURLSessionConfiguration {
    return NSURLSessionConfiguration.defaultSessionConfiguration()
  }
  
  var session: NSURLSession {
    return NSURLSession.sharedSession()
  }
  
  // TODO: 处理请求失败的情况
  func startRequest() {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    let task = session.dataTaskWithRequest(requset) {
      data, response, error in
      guard let data = data else { return }
      NSOperationQueue.mainQueue().addOperationWithBlock({
        let json = JSON(data: data)
        if let viewModule = self.formatter?.formatData(json) {
          self.delegate?.didReceiveApiViewModule(viewModule) // 处理复杂json转化，给vc输出专用viewmodule
        } else {
          self.delegate?.didReceiveApiJson(json) // 处理无关view层的数据获取
        }
      })
    }
    task.resume()
  }
}

protocol NetworkDelegate: class {
  func didReceiveApiViewModule(viewModule: ViewModule) // 可选方法
  func didReceiveApiJson(json: JSON) // 可选方法
  func receiveWithError()
}

extension NetworkDelegate {
  func didReceiveApiViewModule(viewModule: ViewModule) {}
  func didReceiveApiJson(json: JSON) {}
}

protocol ViewModule {
  
}


protocol ApiDataFormatter {
  func formatData(data: JSON) -> ViewModule?
}



