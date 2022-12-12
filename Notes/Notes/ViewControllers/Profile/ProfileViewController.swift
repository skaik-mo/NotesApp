//  Skaik_mo
//
//  ProfileViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 10/12/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var letterNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var numberOfCategoriesLabel: UILabel!
    @IBOutlet weak var doneNotesLabel: UILabel!
    @IBOutlet weak var numberOfDoneNotesLabel: UILabel!
    @IBOutlet weak var waitingNotesLabel: UILabel!
    @IBOutlet weak var numberOfWaitingNotesLabel: UILabel!
    @IBOutlet weak var firstNameTextField: GeneralTextField!
    @IBOutlet weak var lastNameTextField: GeneralTextField!
    @IBOutlet weak var phoneTextField: GeneralTextField!
    @IBOutlet weak var saveButton: GeneralButton!

    var user: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpData()
        self.fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func saveAction(_ sender: Any) {
        self.save()
    }

}

// MARK: - ViewDidLoad
extension ProfileViewController {

    private func setUpView() {
        self.phoneTextField.keyboardType = .phonePad
        self.saveButton.corner = 10
    }

    private func setUpData() {
        self.title = PROFILE_TITLE
        self.categoriesLabel.text = CATEGORIES_TITLE
        self.doneNotesLabel.text = DONE_NOTES_TITLE
        self.waitingNotesLabel.text = WAITING_NOTES_TITLE
        self.firstNameTextField.placeholder = FIRST_NAME_TITLE
        self.lastNameTextField.placeholder = LAST_NAME_TITLE
        self.phoneTextField.placeholder = PHONE_TITLE
    }

    private func fetchData() {
        self.fetchUserData()
        let categories = CategoryController.shared.fetchCategories()
        self.numberOfCategoriesLabel.text = categories.count._toString
        let status = NoteController.shared.getDoneAndWaitingNotes(categories: categories)
        self.numberOfDoneNotesLabel.text = status.doneNotes._toString
        self.numberOfWaitingNotesLabel.text = status.waitingNotes._toString
    }

    private func fetchUserData() {
        self.user = UserDefaults.standard.getLocalUser()
        if let user, let firstName = user.firstName, let lastName = user.lastName, let email = user.email, let phone = user.phone {
            self.letterNameLabel.text = firstName.first?.uppercased()
            self.fullNameLabel.text = "\(firstName) \(lastName)"
            self.emailLabel.text = email
            self.firstNameTextField.text = firstName
            self.lastNameTextField.text = lastName
            self.phoneTextField.text = phone
        }
    }

}

extension ProfileViewController {

    private func checkData() -> String? {
        if self.firstNameTextField.text.isEmpty {
            return ENTER_FIRST_NAME_MESSAGE
        }
        if self.lastNameTextField.text.isEmpty {
            return ENTER_LAST_NAME_MESSAGE
        }
        if self.phoneTextField.text.isEmpty {
            return ENTER_PHONE_MESSAGE
        }
        return nil
    }

    private func setUser() {
        self.user?.firstName = self.firstNameTextField.text
        self.user?.lastName = self.lastNameTextField.text
        self.user?.phone = self.phoneTextField.text
    }

    private func save() {
        if let errorMessage = checkData() {
            self._showErrorAlertOK(message: errorMessage)
            return
        }
        self.setUser()
        UserController.shared.saveUser(userModel: self.user)
        self.fetchUserData()
        self._showAlertOK(title: PROFILE_UPDATED_TITLE, message: PROFILE_UPDATED_SUCCESS_MESSAGE)
    }
}
