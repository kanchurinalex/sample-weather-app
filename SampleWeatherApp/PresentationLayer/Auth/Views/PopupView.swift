//
//  PastePopupView.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 04.12.2020.
//

import UIKit

final class PopupView: UIView {
  
  private let titleButton = UIButton()
  
  // MARK: - Interface
  
  var text: String? {
    get { titleButton.title(for: .normal) }
    set { titleButton.setTitle(newValue, for: .normal) }
  }
  
  var tapClosure: (() -> Void)?
  
  // MARK: - Override
  
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
    
    titleButton.frame = bounds
    
    let radius = CornerRadius.small.rawValue
    let arrowHeight = Constants.arrowHeight
    
    let path = UIBezierPath()
    path.addLine(to: CGPoint(x: 0, y: radius))
    path.addArc(withCenter: CGPoint(x: radius, y: radius),
                radius: radius,
                startAngle: -CGFloat.pi,
                endAngle: -CGFloat.pi / 2,
                clockwise: true)
    path.addLine(to: CGPoint(x: bounds.width - radius, y: 0))
    path.addArc(withCenter: CGPoint(x: bounds.width - radius, y: radius),
                radius: radius,
                startAngle: -CGFloat.pi / 2,
                endAngle: 0,
                clockwise: true)
    path.addLine(to: CGPoint(x: bounds.width, y: bounds.height - arrowHeight - radius))
    path.addArc(withCenter: CGPoint(x: bounds.width - radius, y: bounds.height - arrowHeight - radius),
                radius: radius,
                startAngle: 0,
                endAngle: CGFloat.pi / 2,
                clockwise: true)
    path.addLine(to: CGPoint(x: bounds.width / 2 + arrowHeight / 2, y: bounds.height - arrowHeight))
    path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))
    path.addLine(to: CGPoint(x: bounds.width / 2 - arrowHeight / 2, y: bounds.height - arrowHeight))
    path.addLine(to: CGPoint(x: radius, y: bounds.height - arrowHeight))
    path.addArc(withCenter: CGPoint(x: radius, y: bounds.height - arrowHeight - radius),
                radius: radius,
                startAngle: CGFloat.pi / 2,
                endAngle: CGFloat.pi,
                clockwise: true)
    path.close()
    
    (titleButton.layer.mask as? CAShapeLayer)?.path = path.cgPath
    
    layer.shadowPath = path.cgPath
  }
  
  // MARK: Private. Setup
  
  private func setup() {
    backgroundColor = .clear
    layer.setupDefaultShadow()
    
    titleButton.translatesAutoresizingMaskIntoConstraints = false
    titleButton.backgroundColor = .white
    titleButton.setTitleColor(.black, for: .normal)
    addSubview(titleButton)
    
    titleButton.layer.mask = CAShapeLayer()
    
    titleButton.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
  }
  
  // MARK: Private. Actions
  
  @objc private func tap(_ sender: UIButton) {
    tapClosure?()
  }
}

// MARK: - Private. Constants

extension PopupView {
  
  private enum Constants {
    static let arrowHeight: CGFloat = 12
  }
}
