//
//  ViewController.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/14.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit
import SafariServices
import Kingfisher

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var apiManager: DailyApi!
  var viewModule: DailyViewModule?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    title = "Gank.io"
    apiManager = DailyApi(day: NSDate.dailyApiDate(), delegate: self)
    apiManager.startRequest()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func setHeaderView() {
    let imageUrl = viewModule?.getDailyImage()!
    let welfareImage = UIImageView()
    welfareImage.kf_setImageWithURL(imageUrl, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) {
      [weak self] (image, error, cacheType, imageURL) in
      if let image = image {
        welfareImage.frame = CGRect(x: 0, y: 0, width: Screen.width, height: image.constrainHeight)
        self?.tableView.tableHeaderView = welfareImage
      }
    }
  }
}

extension ViewController: NetworkDelegate {
  func didReceiveApiData(data: ViewModule) {
    viewModule = data as? DailyViewModule
    tableView.reloadData()
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    setHeaderView()
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
    tableView.cellForRowAtIndexPath(indexPath)?.selected = false
    var module = viewModule?.moduleAtIndexPath(indexPath)
    let safariVC = SFSafariViewController(URL: (module?.URL.toNSURL())!)
    self.navigationController?.pushViewController(safariVC, animated: true)
    self.navigationController?.setStatusAndNavBarHidden(0)
  }
}

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    self.navigationController?.setStatusAndNavBarHidden(scrollView.ratio)
  }
}

