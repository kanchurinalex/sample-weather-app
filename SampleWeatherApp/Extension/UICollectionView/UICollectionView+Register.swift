//
//  UICollectionView+Register.swift
//  revolut
//
//  Created by alex on 29.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  func register<T: UICollectionViewCell>(_ cellType: T.Type) where T: ReusableView {
    register(T.self, forCellWithReuseIdentifier: T.reuseId)
  }
  
  func register<T: UICollectionViewCell>(_ cellType: T.Type) where T: ReusableView, T: NibLoadable {
    register(T.nib, forCellWithReuseIdentifier: T.reuseId)
  }
  
  func registerHeader<T: UICollectionReusableView>(_ headerType: T.Type) where T: ReusableView {
    register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseId)
  }
  
  func registerHeader<T: UICollectionReusableView>(_ headerType: T.Type) where T: ReusableView, T: NibLoadable {
    register(T.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseId)
  }
}
