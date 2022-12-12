//  Skaik_mo
//
//  UITableView.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import Foundation
import UIKit

extension UITableView {

    //MARK: Register
    /// Register Cell
    var _registerCell: UITableViewCell.Type {
        set {
            self.register(UINib(nibName: newValue.self._id, bundle: nil), forCellReuseIdentifier: newValue.self._id)
        }
        get {
            return UITableViewCell.self
        }
    }
    
    /// Register Header And Footer
    var _registerHeaderAndFooter: UITableViewHeaderFooterView.Type {
        set {
            self.register(UINib(nibName: newValue.self._id, bundle: nil), forHeaderFooterViewReuseIdentifier: newValue.self._id)
        }
        get {
            return UITableViewHeaderFooterView.self
        }
    }

    //MARK: Dequeue
    // Dequeue Cell
    func _dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with identifier \((T.self)._id) in storyboard.")
        }
        return cell
    }
    
    func _dequeueReusableCell<T: UITableViewCell>(withIdentifier identifier: String) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError("Could not locate viewcontroller with identifier \(identifier) in storyboard.")
        }
        return cell
    }
    
    // Dequeue Header And Footer
    func _dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type = T.self) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(name._id), make sure the view is registered with table view")
        }
        return headerFooterView
    }

}
