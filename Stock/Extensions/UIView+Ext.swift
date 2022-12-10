//
//  UIView+Ext.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 06.11.2022.
//

import Foundation
import UIKit

private let padding: CGFloat = 10

extension UIView {    
    var width: CGFloat { frame.size.width }
    var height: CGFloat { frame.size.height }
    var leading: CGFloat { frame.origin.x }
    var trailing: CGFloat { leading + width }
    var top: CGFloat { frame.origin.y }
    var bottom: CGFloat { top + height }
}

// MARK: Add all subbviews to vc by array

extension UIView {
    func addAllSubbviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

// MARK: - AlertVC

extension UIView {
    func setAlertContainer(view: UIView, container: UIView) {
        view.addSubview(container)
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.red.cgColor
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.heightAnchor.constraint(equalToConstant: 220),
            container.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func setAlertButton(view: UIView, button: UIButton) {
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding * 2),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 3),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 3),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setAlertLabel(view: UIView, button: UIButton, label: UILabel) {
        label.numberOfLines = 4
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: padding * 2),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -padding * 2)
        ])
    }
}
