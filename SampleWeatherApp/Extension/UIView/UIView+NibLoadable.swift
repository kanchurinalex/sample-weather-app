//
//  UIView+NibLoadable.swift
//  revolut
//
//  Created by alex on 28.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

protocol NibLoadable {
    
  static var nibName: String { get }
    
  static var nib: UINib { get }
    
  static func loadFromNib() -> Self
}

extension NibLoadable where Self: UIView {
  
  static var nibName: String {
    return String(describing: self)
  }
  
  static var nib: UINib {
    return UINib(nibName: nibName, bundle: nil)
  }
  
  static func loadFromNib() -> Self {
    let view = nib.instantiate(withOwner: self, options: nil).first as! Self
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
}
