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
// MARK: Outlet and properties
  @IBOutlet weak var tableView: UITableView!
  var apiManager: DailyApi!
  var dateManager: PublishDateApi!
  var dailyViewModule: DailyViewModule?
  var publishedDates: [String]?
  var pageIndex = 0
  
  let transition = NavigationAnimator()

// MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Gank.io"
    tableView.contentInset.top = Screen.navBarHeight
    navigationItem.hidesBackButton = true
    navigationController?.delegate = self
    
    // TODO: 糟糕的实现
    if let publishedDates = publishedDates {
      apiManager = DailyApi(day: publishedDates[pageIndex], delegate: self)
      apiManager.startRequest()
    } else {
      dateManager = PublishDateApi()
      dateManager.startRequest()
      dateManager.apiCompleted = { [weak self] dates in
        self?.publishedDates = dates
        self?.apiManager = DailyApi(day: dates[0], delegate: self)
        self?.apiManager.startRequest()
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func shouldAutorotate() -> Bool {
    return false
  }
  
  deinit {
    print("首页成功释放")
  }

// MARK: Helper method
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
  
  private func initViewController(isNext nextPage: Bool) -> ViewController?{
    if let vc = storyboard?.instantiateViewControllerWithIdentifier("ViewController") as? ViewController{
      vc.publishedDates = publishedDates
      vc.pageIndex = nextPage ? pageIndex+1 : pageIndex-1
      return vc
    }
    return nil
  }
  
  private func pushToViewController(isNext isNext: Bool) {
    if let vc = initViewController(isNext: isNext) {
      transition.isScrollUp = isNext
      navigationController?.pushViewController(vc, animated: true)
      removeFromParentViewController()
      let cache = KingfisherManager.sharedManager.cache
      cache.clearMemoryCache()
    }
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
  // TODO: 未完成请求失败响应
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
    if scrollView.isPullUpToNextPage {
      pushToViewController(isNext: true)
    }
    
    if scrollView.isPullDownToPreviousPage {
      if pageIndex == 0 { return }
        pushToViewController(isNext: false)
    }
  }
}

// MARK: UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    switch operation {
    case .Push:
      return transition
    default:
      return nil
    }
  }
}
