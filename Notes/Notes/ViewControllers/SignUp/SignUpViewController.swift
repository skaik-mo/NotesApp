//  Skaik_mo
//
//  SignUpViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 05/12/2022.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var firstNameTextField: GeneralTextField!
    @IBOutlet weak var lastNameTextField: GeneralTextField!
    @IBOutlet weak var emailTextField: GeneralTextField!
    @IBOutlet weak var phoneTextField: GeneralTextField!
    @IBOutlet weak var passwordTextField: GeneralTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func signUpAction(_ sender: Any) {
        self.signUp()
    }

}

// MARK: - ViewDidLoad
extension SignUpViewController {

    private func setUpView() {
        self.emailTextField.keyboardType = .emailAddress
        self.phoneTextField.keyboardType = .phonePad
        self.passwordTextField.isSecureText = true
    }

    private func setUpData() {
        self.title = ""
        self.signUpLabel.text = SIGN_UP_TITLE
        self.createAccountLabel.text = CREATE_ACCOUNT_TITLE
        self.firstNameTextField.placeholder = FIRST_NAME_TITLE
        self.lastNameTextField.placeholder = LAST_NAME_TITLE
        self.emailTextField.placeholder = Email_TITLE
        self.phoneTextField.placeholder = PHONE_TITLE
        self.passwordTextField.placeholder = PASSWORD_TITLE
    }

}

extension SignUpViewController {

    private func checkData() -> String? {
        if self.firstNameTextField.text.isEmpty {
            return ENTER_FIRST_NAME_MESSAGE
        }
        if self.lastNameTextField.text.isEmpty {
            return ENTER_LAST_NAME_MESSAGE
        }
        if self.emailTextField.text.isEmpty {
            return ENTER_EMAIL_MESSAGE
        }
        if !self.emailTextField.text._isEmailValid {
            return VALID_EMAIL_MESSAGE
        }
        if self.phoneTextField.text.isEmpty {
            return ENTER_PHONE_MESSAGE
        }
        if self.passwordTextField.text.isEmpty {
            return ENTER_PASSWORD_MESSAGE
        }
        return nil
    }

    private func getUser() -> UserModel {
        return UserModel(firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, email: self.emailTextField.text, phone: self.phoneTextField.text, password: self.passwordTextField.text)
    }

    private func signUp() {
        if let errorMessage = checkData() {
            self._showErrorAlertOK(message: errorMessage)
            return
        }
        if let errorMessage = UserController.shared.signUp(userModel: self.getUser()) {
            self._showErrorAlertOK(message: errorMessage)
            return
        }
        // GO CATEGORIES SCREEN
        let vc: CategoriesViewController = CategoriesViewController._instantiateVC()
        vc._rootPush()
    }

}
