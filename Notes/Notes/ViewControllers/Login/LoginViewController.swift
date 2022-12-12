//  Skaik_mo
//
//  LoginViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var LogInToLabel: UILabel!
    @IBOutlet weak var emailTextField: GeneralTextField!
    @IBOutlet weak var passwordTextField: GeneralTextField!
    @IBOutlet weak var signUpButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self._isHideNavigation = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self._isHideNavigation = false
    }

    @IBAction func loginAction(_ sender: Any) {
        self.login()
    }

    @IBAction func signUpAction(_ sender: Any) {
        let vc: SignUpViewController = SignUpViewController._instantiateVC()
        vc._push()
    }

}

// MARK: - ViewDidLoad
extension LoginViewController {

    private func setUpView() {
        self.emailTextField.keyboardType = .emailAddress
        self.passwordTextField.isSecureText = true
    }

    private func setUpData() {
        self.title = ""
        self.signInLabel.text = SIGN_IN_TITLE
        self.LogInToLabel.text = LOGINT_TO_TITLE
        self.emailTextField.placeholder = Email_TITLE
        self.passwordTextField.placeholder = PASSWORD_TITLE
        self.signUpButton.setTitle(DO_NOT_HAVE_AN_ACCOUNT, for: .normal)
        self.signUpButton._setAttributedString(rang: SIGN_UP_TITLE, attributed: [NSAttributedString.Key.foregroundColor: color_23203F, NSAttributedString.Key.font: fontRobotoMedium18 ?? UIFont.systemFont(ofSize: 18, weight: .medium)])
    }

}


extension LoginViewController {

    private func checkData() -> String? {
        if self.emailTextField.text.isEmpty {
            return ENTER_EMAIL_MESSAGE
        }
        if !self.emailTextField.text._isEmailValid {
            return VALID_EMAIL_MESSAGE
        }
        if self.passwordTextField.text.isEmpty {
            return ENTER_PASSWORD_MESSAGE
        }
        return nil
    }

    private func getUser() -> UserModel {
        return UserModel(email: self.emailTextField.text, password: self.passwordTextField.text)
    }

    private func login() {
        if let errorMessage = checkData() {
            self._showErrorAlertOK(message: errorMessage)
            return
        }
        if let errorMessage = UserController.shared.login(userModel: self.getUser()) {
            self._showErrorAlertOK(message: errorMessage)
            return
        }
        // GO CATEGORIES SCREEN
        let vc: CategoriesViewController = CategoriesViewController._instantiateVC()
        vc._rootPush()
    }

}
