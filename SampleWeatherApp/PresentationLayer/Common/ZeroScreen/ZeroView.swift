//
//  ZeroView.swift
//  revolut
//
//  Created by alex on 07.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

final class ZeroView: UIView, NibLoadable {
  
  @IBOutlet private var imageView: UIImageView!
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var actionButton: UIButton!
  
  // MARK: - Interface
  
  enum Style {
    case empty
    case error
  }
  
  var action: (() -> Void)?
  
  func setImage(_ image: UIImage?, title: String, actionTitle: String, style: Style) {
    imageView.image = image
    imageView.tintColor = style.color
    
    let titleText = NSMutableAttributedString()
    titleText.appendParagraph(string: title, font: .systemFont(ofSize: 15), color: style.color, aligment: .center)
    titleLabel.attributedText = titleText
    
    let actionTitleText = NSMutableAttributedString()
    actionTitleText.appendParagraph(string: actionTitle, font: .systemFont(ofSize: 15, weight: .semibold), color: .white, aligment: .center)
    actionButton.setAttributedTitle(actionTitleText, for: .normal)
  }
  
  // MARK: - Override
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let path = UIBezierPath(roundedRect: actionButton.bounds, cornerRadius: CornerRadius.small.rawValue)
    (actionButton.layer.mask as? CAShapeLayer)?.path = path.cgPath
  }
  
  // MARK: - Private. Setup
  
  private func setup() {
    actionButton.layer.mask = CAShapeLayer()
    
    actionButton.backgroundColor = .systemBlue
    actionButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
  }
  
  // MARK: - Private. Actions
  
  @objc private func tap() {
    action?()
  }
}

// MARK: - Private. Style + Color

private extension ZeroView.Style {
  
  var color: UIColor {
    switch self {
    case .empty: return .systemBlue
    case .error: return .red
    }
  }
}

// MARK: - Private. Constants

extension ZeroView {
  
  private enum Constants {
    static let cornerRadius: CGFloat = 10
  }
}
