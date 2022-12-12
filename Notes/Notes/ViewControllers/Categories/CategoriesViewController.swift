//  Skaik_mo
//
//  CategoriesViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 06/12/2022.
//

import UIKit

class CategoriesViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: GeneralTableView!
    
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self._isHideNavigation = false
        self.title = CATEGORIES_TITLE
        self.fetchData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    @IBAction func settingsAction(_ sender: Any) {
        let vc: SettingsViewController = SettingsViewController._instantiateVC()
        vc._push()
    }
    
    @IBAction func addCategoryAction(_ sender: Any) {
        let vc: AddOrEditViewController = AddOrEditViewController._instantiateVC()
        vc.typeView = .AddCategory
        vc._push()
    }
    
}

// MARK: - ViewDidLoad
extension CategoriesViewController {

    private func setUpView() {
        self.setUpTableView()
    }

    private func fetchData() {
        self.tableView.resetTableView(objects: CategoryController.shared.fetchCategories())
    }
    
    private func setUpTableView() {
        self.tableView.cell = CategoryTableViewCell.self
        self.tableView.cellHeight = 80
        self.tableView.contentInset = UIEdgeInsets.init(top: 25, left: 0, bottom: 10, right: 0)
        self.tableView.emptyImage = ic_noCategories
        self.tableView.titleEmpty = NO_CATEGORIES_TITLE
    }

}
