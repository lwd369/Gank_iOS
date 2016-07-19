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
  var dateManager: PublishDateApi!
  var dailyViewModule: DailyViewModule?

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Gank.io"
    transitioningDelegate = self
    // TODO: 糟糕的实现
    dateManager = PublishDateApi()
    dateManager.startRequest()
    dateManager.apiCompleted = { [weak self] dates in
      self?.apiManager = DailyApi(day: dates[0], delegate: self)
      self?.apiManager.startRequest()
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func setHeaderView() {
    if let imageUrl = dailyViewModule?.getDailyImage() {
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
  
  @IBAction func editSectionOrder(sender: UIBarButtonItem) {
    let sectionOrderVc = SectionOrderViewController(category: dailyViewModule!.category, completion: { [weak self] in
      self?.dailyViewModule?.category = $0
      self?.tableView.reloadData()
    })
    let navVc = UINavigationController(rootViewController: sectionOrderVc)
    self.navigationController?.presentViewController(navVc, animated: true, completion: nil)
  }
}

// MARK: NetworkDelegate
extension ViewController: NetworkDelegate {
  func didReceiveApiViewModule(viewModule: ViewModule) {
    dailyViewModule = viewModule as? DailyViewModule
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    setHeaderView()
    self.tableView.reloadData()
  }
  
  func receiveWithError() {
    print("解析失败")
  }
}

// MARK: TableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    let result = dailyViewModule?.numberOfSection() ?? 0
    return result
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let result = dailyViewModule?.numberOfRowsInSection(section) ?? 0
    return result
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell")
    cell?.textLabel?.text = dailyViewModule?.titleForIndexPath(indexPath)
    return cell!
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return dailyViewModule?.titleForSection(section)
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    var module = dailyViewModule?.moduleAtIndexPath(indexPath)
    let safariVC = SFSafariViewController(URL: (module?.URL.toNSURL())!)
    self.presentViewController(safariVC, animated: true, completion: nil)
  }
}

// MARK: ScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if scrollView.contentOffset.y / scrollView.contentSize.height > 0.6 {
      if let vc = storyboard?.instantiateViewControllerWithIdentifier("ViewController") {
        self.presentViewController(vc, animated: true, completion: nil)
      }
    }
  }
}

// MARK: ViewControllerTransitioningDelegate
extension ViewController: UIViewControllerTransitioningDelegate {
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PresentAnimator()
  }
  
}
