//
//  PageHeaderView.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/20.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import UIKit

class PageHeaderView: UIView {
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFontOfSize(13.0)
    return label
  }()
  
  var title: String? {
    get {
      return titleLabel.text
    }
    set (newText) {
      titleLabel.text = newText
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initMethod()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initMethod()
  }
  
  private func initMethod() {
    backgroundColor = UIColor.blueColor()
    addSubview(titleLabel)
    NSLayoutConstraint.activateConstraints([
      titleLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      titleLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor)
    ])
  }
}
