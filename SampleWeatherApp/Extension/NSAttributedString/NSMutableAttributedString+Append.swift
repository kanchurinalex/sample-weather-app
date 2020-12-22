//
//  NSMutableAttributedString.swift
//  revolut
//
//  Created by alex on 01.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
  
  @discardableResult
  func appendParagraph(string: String,
                       font: UIFont,
                       color: UIColor,
                       aligment: NSTextAlignment,
                       spacingBefore: CGFloat = 0,
                       newLine: Bool = false) -> NSMutableAttributedString {

    if newLine {
      self.append(NSMutableAttributedString(string: "\n"))
    }
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.paragraphSpacingBefore = spacingBefore
    paragraphStyle.alignment = aligment
    
    let attributes: [NSAttributedString.Key: Any] = [.font: font,
                                                     .foregroundColor: color,
                                                     .paragraphStyle: paragraphStyle]
    
    self.append(NSMutableAttributedString(string: string, attributes: attributes))
    
    return self
  }
}
