//
//  DailyViewModule.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation

struct DailyViewModule: ViewModule {
  
  var category: [String]
  var result: [String: Array<GanhuoModule>]
  
  func numberOfSection() -> Int {
    return category.count
  }
  
  func numberOfRowsInSection(section: Int) -> Int {
    let indexPath = NSIndexPath(forRow: 0, inSection: section)
    if let element =  elementInResult(indexPath) {
      return element.count
    }
    return 0
  }
  
  func titleForIndexPath(indexPath: NSIndexPath) -> String? {
    let row = indexPath.row
    if var element =  elementInResult(indexPath) {
      return element[row].Title
    }
    return nil
  }
  
  func titleForSection(section: Int) -> String? {
    let indexPath = NSIndexPath(forRow: 0, inSection: section)
    return category[indexPath.section]
  }
  
  func moduleAtIndexPath(indexPath: NSIndexPath) -> GanhuoModule? {
    let row = indexPath.row
    if var element =  elementInResult(indexPath) {
      return element[row]
    }
    return nil
  }
  
  private func elementInResult(indexPath: NSIndexPath) -> [GanhuoModule]? {
    let section = indexPath.section
    
    let categoryTitle = category[section]
    if let element = result[categoryTitle] {
      return element
    }
    
    return nil
  }
}