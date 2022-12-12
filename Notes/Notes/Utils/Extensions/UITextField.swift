//  Skaik_mo
//
//  UITextField.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import Foundation
import UIKit

extension UITextField {

    @IBInspectable var paddingLeftCustom: CGFloat {
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
        get {
            return leftView!.frame.size.width
        }
    }

    @IBInspectable var paddingRightCustom: CGFloat {
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
        get {
            return rightView!.frame.size.width
        }
    }

    var _getText: String {
        var value = ""
        if let _text = self.text {
            value = _text._removeWhiteSpace
        }
        return value
    }

}
