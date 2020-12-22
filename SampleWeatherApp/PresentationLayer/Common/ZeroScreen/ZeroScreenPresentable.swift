//
//  ZeroScreenPresentable.swift
//  revolut
//
//  Created by alex on 07.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

enum ZeroScreenStyle {
  case empty
  case error
}

protocol ZeroScreenPresentable {
  
  func showZeroScreen(style: ZeroScreenStyle, title: String, actionTitle: String, action: @escaping (() -> Void))
  
  func hideZeroScreen()
}

// MARK: - Extension for view COntrollers

extension ZeroScreenPresentable where Self: UIViewController {
  
  func showZeroScreen(style: ZeroScreenStyle, title: String, actionTitle: String, action: @escaping (() -> Void)) {
    var zeroView = view.subviews.first(where: { $0 is ZeroView }) as? ZeroView
    
    if zeroView == nil {
      let newZeroView = ZeroView.loadFromNib()
      
      newZeroView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(newZeroView)
      
      NSLayoutConstraint.activate([
        newZeroView.topAnchor.constraint(equalTo: view.topAnchor),
        newZeroView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        newZeroView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        newZeroView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
      
      zeroView = newZeroView
    }
    
    zeroView?.setImage(style.image, title: title, actionTitle: actionTitle, style: style.zeroViewStyle)
    
    zeroView?.action = action
  }
  
  func hideZeroScreen() {
    guard let zeroView = view.subviews.first(where: { $0 is ZeroView }) as? ZeroView else { return }
    zeroView.removeFromSuperview()
  }
}

// MARK: - Private. ZeroScreenStyle + UI

private extension ZeroScreenStyle {
  
  var image: UIImage? {
    switch self {
    case .empty:
      return UIImage(named: "plus")
    
    case .error:
      return UIImage(named: "alert")
    }
  }
  
  var zeroViewStyle: ZeroView.Style {
    switch self {
    case .empty:
      return .empty
    
    case .error:
      return .error
    }
  }
}
