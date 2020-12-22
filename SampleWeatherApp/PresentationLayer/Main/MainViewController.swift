//
//  MainViewController.swift
//  revolut
//
//  Created by alex on 25.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController, ActivityPresentable, ZeroScreenPresentable {
    
  @IBOutlet private var collectionView: UICollectionView!
  
  var viewModel: MainViewModel!
  
  private var items: [Weather] = []
  
  // MARK: Override
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindViewModel()
    
    viewModel.viewLoaded()
  }
  
  // MARK: Private. Setup
  
  private func setupUI() {
    title = "Weather"
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.contentInset = Constants.contentInsets
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(CityWeatherCell.self)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(add(_:)))
  }
  
  private func bindViewModel() {
    viewModel.processState = { [weak self] state in
      guard let self = self else { return }
      
      self.hideZeroScreen()
      
      switch state {
      case .isLoading:
        break
      
      case let .items(items):
        self.items = items
        
        guard !items.isEmpty else {
          self.collectionView.reloadData()
          self.showEmptyState()
          return
        }
        
        self.collectionView.reloadData()
        
      case .error(let error):
        self.show(error: error)
      }
    }
  }
  
  // MARK: Private. Actions
  
  @objc private func add(_ sender: Any) {
    viewModel.addCity()
  }
  
  // MARK: Private. ZeroViews
  
  private func showEmptyState() {
    showZeroScreen(style: .empty, title: "Add new city", actionTitle: "Add") { [weak self] in
      guard let self = self else { return }
      self.viewModel.addCity()
    }
  }
  
  private func show(error: Error) {
    showZeroScreen(style: .error, title: error.localizedDescription, actionTitle: "Try again") { [weak self] in
      guard let self = self else { return }
      self.viewModel.viewLoaded()
    }
  }
}

// MARK: - CollectionView

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CityWeatherCell = collectionView.dequeue(forIndexPath: indexPath)
    
    let item = items[indexPath.row]
    cell.set(cityName: item.cityName, temperature: item.temp)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width - Constants.contentInsets.left - Constants.contentInsets.right - 16
    return CGSize(width: width / 2, height: Constants.cellHeight)
  }
}

// MARK: - Private. Constants

extension MainViewController {
  
  private enum Constants {
    static let cellHeight: CGFloat = 200
    static let contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  }
}
