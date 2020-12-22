//
//  ActivityPresentable.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 22.12.2020.
//

import UIKit

protocol ActivityPresentable {
  
  func showActivity()
  
  func showActivity(on view: UIView)
  
  func hideActivity()
  
  func hideActivity(from view: UIView)
}

extension ActivityPresentable where Self: UIViewController {
  
  func showActivity() {
    showActivityImp(view: self.view)
  }
  
  func showActivity(on view: UIView) {
    showActivityImp(view: view)
  }
  
  func hideActivity() {
    hideActivityImp(view: self.view)
  }
  
  func hideActivity(from view: UIView) {
    hideActivityImp(view: view)
  }
}

// MARK: - Private. Implementation

extension ActivityPresentable {
  
  private func showActivityImp(view: UIView) {
    hideActivityImp(view: view)
    
    let activity = UIActivityIndicatorView()
    activity.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    activity.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(activity)
    NSLayoutConstraint.activate([
      activity.topAnchor.constraint(equalTo: view.topAnchor),
      activity.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      activity.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      activity.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    activity.startAnimating()
  }
  
  private func hideActivityImp(view: UIView) {
    guard let activity = view.subviews.first(where: { $0 is UIActivityIndicatorView }) else { return }
    activity.removeFromSuperview()
  }
}
