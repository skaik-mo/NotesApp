//  Skaik_mo
//
//  GeneralTableViewCell.swift
//  Notes
//
//  Created by Mohammed Skaik on 07/12/2022.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {

    var object: Any?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configerCell() {

    }

    func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
