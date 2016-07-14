//
//  ViewController.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NetworkDelegate {
  @IBOutlet weak var tableView: UITableView!
  var apiManager: DailyApi!
  var viewModule: DailyViewModule?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    apiManager = DailyApi(day: "2016/07/14", delegate: self)
    apiManager.startRequest()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func didReceiveApiData(data: ViewModule) {
    viewModule = data as! DailyViewModule
    tableView.reloadData()
  }
  
  func receiveWithError() {
    print("解析失败")
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    let result = viewModule?.numberOfSection() ?? 0
    return result
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let result = viewModule?.numberOfRowsInSection(section) ?? 0
    return result
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell")
    cell?.textLabel?.text = viewModule?.titleForIndexPath(indexPath)
    return cell!
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModule?.titleForSection(section)
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var module = viewModule?.moduleAtIndexPath(indexPath)
    let vc = WebViewController(url: (module?.URL)!)
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
}

