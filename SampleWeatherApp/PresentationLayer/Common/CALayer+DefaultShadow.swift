//
//  CALayer+Shadow.swift
//  revolut
//
//  Created by alex on 07.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

extension CALayer {
  
  func setupDefaultShadow() {
    shadowOpacity = 1
    shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
    shadowOffset = CGSize(width: 0, height: 3)
    shadowRadius = 10
  }
}
