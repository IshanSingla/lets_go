//
//  UiView.swift
//  lets_go
//
//  Created by Ishan Singla on 05/05/24.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map(UIColor.init)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var padding: CGFloat {
        get {
            return 0
        }
        set {
            self.layoutMargins = UIEdgeInsets(top: newValue, left: newValue, bottom: newValue, right: newValue)
        }
    }
}
