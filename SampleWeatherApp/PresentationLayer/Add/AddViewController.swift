//
//  AddViewController.swift
//  revolut
//
//  Created by alex on 01.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

final class AddViewController: UIViewController, ZeroScreenPresentable, ActivityPresentable {
  
  @IBOutlet private var textField: UITextField!
  @IBOutlet private var addButton: UIButton!
  
  var viewModel: AddViewModel!
  
  // MARK: - Override
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindViewModel()
    
    viewModel.viewLoaded()
  }
  
  // MARK: - Private. Setup
  
  private func setupUI() {
    textField.backgroundColor = .lightGray
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
    view.addGestureRecognizer(tapRecognizer)
  }
  
  private func bindViewModel() {
    viewModel.processState = { [weak self] state in
      guard let self = self else { return }
      
      self.hideZeroScreen()
      self.hideActivity(from: self.addButton)
      
      switch state {
      case .initial:
        break
    
      case .isLoading:
        self.showActivity(on: self.addButton)
        
      case .error(let error):
        self.show(error: error)
      }
    }
  }
  
  // MARK: - Private. Actions
  
  @objc private func tap(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  @IBAction private func add(_ sender: Any) {
    guard let text = textField.text, !text.isEmpty else { return }
    viewModel.checkCity(text)
  }
  
  // MARK: - Private. ZeroViews
  
  private func show(error: Error) {
    showZeroScreen(style: .error, title: error.localizedDescription, actionTitle: "Try again") { [weak self] in
      guard let self = self else { return }
      self.viewModel.viewLoaded()
    }
  }
}

// MARK: - Private. Constants

extension AddViewController {
  
  private enum Constants {}
}
