//
//  DailyFormatter.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DailyFormatter: ApiDataFormatter {
  
  func formatData(data: JSON) -> ViewModule? {
    let category = parseCategory(data)
    let result = parseResult(data, category: category)
    
    let dailyViewModule = DailyViewModule(category: category, result: result)
    return dailyViewModule
  }
  
  private func parseResult(data: JSON, category: [String]) -> [String: Array<GanhuoModule>] {
    var result = [String: Array<GanhuoModule>]()

    for title in category {
      let subArray = data["results"][title]
      var tempArray = Array<GanhuoModule>()
      for (_, subJson) in subArray {
        let module = GanhuoModule(rawJSON: subJson)
        tempArray.append(module)
      }
      result[title] = tempArray
    }
    return result
  }
  
  private func parseCategory(data: JSON) -> [String] {
    let categoryJSON = data["category"]
    var result = [String]()
    for (_, subJson) in categoryJSON {
      result.append(subJson.stringValue)
    }
    return result
  }
  
}