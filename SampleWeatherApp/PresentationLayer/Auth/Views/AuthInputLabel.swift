//
//  AuthInputLabel.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 04.12.2020.
//

import UIKit

final class AuthInputLabel: UILabel {
  
  // MARK: Override
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let path = UIBezierPath(roundedRect: bounds, cornerRadius: CornerRadius.small.rawValue)
    (layer.mask as? CAShapeLayer)?.path = path.cgPath
  }
  
  // MARK: Private. Setup
  
  private func setup() {
    backgroundColor = UIColor.lightGray
    textAlignment = .center
    layer.mask = CAShapeLayer()
  }
}
