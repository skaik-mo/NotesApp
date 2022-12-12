//  Skaik_mo
//
//  SettingsViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 09/12/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var letterNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: GeneralTableView!

    var objects: [SettingModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpData()
        self.setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = SETTINGS_TITLE
        self.fetchData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }

}

// MARK: - ViewDidLoad
extension SettingsViewController {

    private func setUpData() {
        self.objects.append(.init(icon: ic_language, title: LANGUAGE_TITLE, subTitle: SELECTED_LANGUAGE_TITLE + Language.shared.currentAppleLanguage(), setting: .Language))
        self.objects.append(.init(icon: ic_profile, title: PROFILE_TITLE, subTitle: UPDATE_DATA_TITLE, setting: .Profile))
        self.objects.append(.init(icon: ic_password, title: CHANGE_PASSWORD_TITLE, subTitle: UPDATE_PASS_TITLE, setting: .ChangePassword))
        self.objects.append(.init(icon: ic_aboutApp, title: ABOUT_APP_TITLE, subTitle: WHAT_IS_NETES_TITLE, setting: .AboutApp))
        self.objects.append(.init(icon: ic_logout, title: LOGOUT_TITLE, subTitle: WAITING_YOUR_RETURN_TITLE, setting: .Logout))
    }

    private func fetchData() {
        if let user = UserDefaults.standard.getLocalUser(), let firstName = user.firstName, let lastName = user.lastName, let email = user.email {
            self.letterNameLabel.text = firstName.first?.uppercased()
            self.fullNameLabel.text = "\(firstName) \(lastName)"
            self.emailLabel.text = email
        }
    }

    private func setUpTableView() {
        self.tableView.cell = SettingTableViewCell.self
        self.tableView.cellHeight = 80
        self.tableView.objects = self.objects
        self.tableView.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 15, right: 0)
    }

}
