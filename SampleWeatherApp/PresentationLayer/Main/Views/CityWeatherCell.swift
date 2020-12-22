//
//  CityWeatherCell.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 22.12.2020.
//

import UIKit

final class CityWeatherCell: UICollectionViewCell, ReusableView, NibLoadable {
  
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var subtitleLabel: UILabel!
  
  // MARK: Interface
  
  func set(cityName: String, temperature: String) {
    titleLabel.text = cityName
    subtitleLabel.text = temperature
  }
  
  // MARK: Override
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    subtitleLabel.text = nil
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let path = UIBezierPath(roundedRect: bounds, cornerRadius: CornerRadius.small.rawValue)
    (contentView.layer.mask as? CAShapeLayer)?.path = path.cgPath
    layer.shadowPath = path.cgPath
  }
  
  // MARK: Private. Setup
  
  private func setup() {
    contentView.layer.mask = CAShapeLayer()
    layer.setupDefaultShadow()
    layer.masksToBounds = false
  }
}
