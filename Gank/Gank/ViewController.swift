//
//  ViewController.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NetworkDelegate {
  var apiManager: DailyApi!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    apiManager = DailyApi(day: "2016/07/08", delegate: self)
    apiManager.startRequest()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func didReceiveApiData(data: ApiData) {
    print("获取数据。。")
  }
  
  func receiveWithError() {
    print("解析失败")
  }

}

