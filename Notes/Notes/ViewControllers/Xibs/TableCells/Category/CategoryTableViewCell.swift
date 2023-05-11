//  Skaik_mo
//
//  CategoryTableViewCell.swift
//  Notes
//
//  Created by Mohammed Skaik on 06/12/2022.
//

import UIKit

class CategoryTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var containerStack: UIStackView!
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configerCell() {
        self.containerStack.layoutMargins = Language().isRTL ? .init(top: 0, left: 0, bottom: 0, right: 15) : .init(top: 0, left: 15, bottom: 0, right: 0)
        if let category = self.object as? Category {
            self.letterLabel.text = category.title?.first?.uppercased()
            self.titleLabel.text = category.title
            self.descriptionLabel.text = category.descriptionCategory
        }

    }

    @IBAction func deleteAction(_ sender: Any) {
        if let category = self.object as? Category, let id = category.id {
            let isDelete = CategoryController.shared.deleteCategory(id: id)
            if isDelete, let parent = AppDelegate.shared?._topVC as? CategoriesViewController, let categories = parent.tableView.objects as? [Category], let index = categories.firstIndex(of: category) {
                parent.tableView.deleteItem(index: index)
            }
        }
    }

    @IBAction func editAction(_ sender: Any) {
        let vc: AddOrEditViewController = AddOrEditViewController._instantiateVC()
        vc.typeView = .EditCategory
        vc.category = self.object as? Category
        vc._push()
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: NotesViewController = NotesViewController._instantiateVC()
        vc.category = self.object as? Category
        vc._push()
    }

}
