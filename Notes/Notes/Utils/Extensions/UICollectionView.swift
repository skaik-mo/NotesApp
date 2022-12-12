//  Skaik_mo
//
//  UICollectionView.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    
    //MARK: Register
    var _registerCell: UICollectionViewCell.Type {
        set {
            self.register(UINib.init(nibName: newValue.self._id, bundle: nil), forCellWithReuseIdentifier: newValue.self._id)
        }
        get {
            return UICollectionViewCell.self
        }
    }

    //MARK: Dequeue
    func _dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type = T.self, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: name._id, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(name._id), make sure the cell is registered with collection view")
         }
         return cell
     }
}
