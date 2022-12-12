//  Skaik_mo
//
//  SettingTableViewCell.swift
//  Notes
//
//  Created by Mohammed Skaik on 09/12/2022.
//

import UIKit

class SettingTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var leadingView: UIView!
    @IBOutlet weak var trailingView: UIView!
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configerCell() {
        if let index, index % 2 == 0 {
            self.leadingView.alpha = 1
            self.trailingView.alpha = 0
        } else {
            self.leadingView.alpha = 0
            self.trailingView.alpha = 1
        }
        if let object = self.object as? SettingModel {
            self.settingImage.image = object.icon
            self.titleLabel.text = object.title
            self.subTitleLabel.text = object.subTitle
        }

    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let object = self.object as? SettingModel {
            object.action()
        }
    }

}
