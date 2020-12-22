//
//  UICollectionView+Deque.swift
//  revolut
//
//  Created by alex on 29.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  func dequeue<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier \(T.reuseId)")
    }
    return cell
  }
  
  func dequeueHeader<T>(forIndexPath indexPath: IndexPath) -> T where T: UICollectionReusableView & ReusableView {
    guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                      withReuseIdentifier: T.reuseId,
                                                      for: indexPath) as? T else {
      fatalError("Could not dequeue view with identifier \(T.reuseId)")
    }
    return view
  }
}
