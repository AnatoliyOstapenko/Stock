//
//  AlertVC.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 10.12.2022.
//

import UIKit

class AlertVC: UIViewController {
    
    private let alertViewContainer = UIView()
    private let alertLabel = NewsCellLabel(ofSize: 14, weight: .black, textColor: .secondaryLabel)
    private let alertButton = StockCustomButton(text: "OK")
    
    weak var coordinator: NewsCoordinatorProtocol?
    
    init(text: CustomErrors) {
        super.init(nibName: nil, bundle: nil)
        DispatchQueue.main.async { self.alertLabel.text = text.rawValue }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private methods
    
    private func configure() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        alertViewContainer.setAlertContainer(view: view, container: alertViewContainer)
        alertButton.setAlertButton(view: alertViewContainer, button: alertButton)
        alertLabel.setAlertLabel(view: alertViewContainer, button: alertButton, label: alertLabel)
        alertButton.addTarget(self, action: #selector(alertButtonPressed), for: .touchUpInside)
    }
    
    @objc private func alertButtonPressed() {
        self.dismiss(animated: true)
        self.coordinator?.stop() // remove child coordinator when Alert deinit
    }
}
