//
//  UIView+Ext.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 06.11.2022.
//

import Foundation
import UIKit

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
