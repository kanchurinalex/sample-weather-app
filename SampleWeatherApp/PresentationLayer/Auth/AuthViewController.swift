//
//  AuthViewController.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 01.12.2020.
//

import UIKit

final class AuthViewController: UIViewController, ZeroScreenPresentable, ActivityPresentable {
  
  @IBOutlet private var inputLabel: AuthInputLabel!
  @IBOutlet private var popupView: PopupView!
  
  var viewModel: AuthViewModel!
  
  // MARK: Override
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindUI()
    bindViewModel()
    
    viewModel.viewLoaded()
  }
  
  // MARK: - Private. Setup
  
  private func setupUI() {
    inputLabel.text = "Input api key"
    popupView.text = "Paste"
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
    inputLabel.addGestureRecognizer(tapRecognizer)
  }
  
  private func bindUI() {
    popupView.tapClosure = { [weak self] in
      guard let self = self else { return }
      
      self.popupView.isHidden.toggle()
      
      if let text = UIPasteboard.general.string {
        self.viewModel.loginWith(apiKey: text)
      }
    }
  }
  
  private func bindViewModel() {
    viewModel.processState = { [weak self] state in
      guard let self = self else { return }
      
      self.hideZeroScreen()
      self.hideActivity()
      
      switch state {
      case .initial:
        break
    
      case .isLoading:
        self.showActivity()
        
      case .error(let error):
        self.show(error: error)
      }
    }
  }
  
  // MARK: - Private. Actions
  
  @objc private func tap(_ sender: UITapGestureRecognizer) {
    popupView.isHidden.toggle()
  }
  
  // MARK: - Private. ZeroViews
  
  private func show(error: Error) {
    showZeroScreen(style: .error, title: error.localizedDescription, actionTitle: "Try again") { [weak self] in
      guard let self = self else { return }
      self.viewModel.viewLoaded()
    }
  }
}
