//
//  Array+Extension.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/18.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import Foundation

extension Array {
  mutating func swapElement(atIndex a: Int, andIndex b: Int) {
    let temp = self[a]
    self[a] = self[b]
    self[b] = temp
  }
  
  mutating func moveingElement(sourceIndex source: Int, toIndex destination: Int) {
    let element = self[source]
    self.removeAtIndex(source)
    self.insert(element, atIndex: destination)
  }
}