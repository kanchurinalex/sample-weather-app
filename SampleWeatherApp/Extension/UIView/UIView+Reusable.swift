//
//  UIView+ResetableView.swift
//  revolut
//
//  Created by alex on 28.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

protocol ReusableView {
  
  static var reuseId: String { get }
}

extension ReusableView where Self: UIView {
  
  static var reuseId: String {
    return String(describing: self)
  }
}
