//  Skaik_mo
//
//  UIStoryboard.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import Foundation
import UIKit

extension UIStoryboard {

    func instantiateVC(withIdentifier identifier: String) -> UIViewController? {
        if let identifiersList = self.value(forKey: "identifierToNibNameMap") as? [String: Any] {
            if identifiersList[identifier] != nil {
                return self.instantiateViewController(withIdentifier: identifier)
            }
        }
        return nil
    }
}


