//
//  SectionOrderViewController.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/18.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

class SectionOrderViewController: UIViewController {
  
  var tableView: UITableView!
  var category: [String]
  var editCompletion: ([String]) -> Void
  
  init(category: [String], completion: ([String]) -> Void) {
    self.category = category
    self.editCompletion = completion
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    layoutTableView()
    registerCell()
    addBackButton()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func layoutTableView() {
    tableView = UITableView(frame: view.bounds)
    tableView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    tableView.delegate = self
    tableView.dataSource = self
    tableView.editing = true
    view.addSubview(tableView)
  }
  
  private func addBackButton() {
    let backButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(editDone))
    self.navigationItem.rightBarButtonItem = backButton
  }
  
  @objc private func editDone() {
    editCompletion(category)
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  private func registerCell() {
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
}

extension SectionOrderViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return category.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell")
    cell?.textLabel?.text = category[indexPath.row]
    return cell!
  }
  
  func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    return .None
  }
  
  func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
  }
  
  func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    let sourseIndex = sourceIndexPath.row
    let toIndex = destinationIndexPath.row
    if sourseIndex != toIndex {
      category.moveingElement(sourceIndex: sourseIndex, toIndex: toIndex)
      print(category)
    }
  }
}
