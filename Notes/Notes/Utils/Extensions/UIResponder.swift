//  Skaik_mo
//
//  UIResponder.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import Foundation
import UIKit

extension UIResponder {
    static var _id: String {
        return String(describing: self)
    }
    
    var _topVC: UIViewController? {
        return AppDelegate.shared?.rootNavigationController?.topViewController
    }
    
}
