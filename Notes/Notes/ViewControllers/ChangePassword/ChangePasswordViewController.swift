//  Skaik_mo
//
//  ChangePasswordViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 10/12/2022.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var currentPasswordTextField: GeneralTextField!
    @IBOutlet weak var newPasswordTextField: GeneralTextField!
    @IBOutlet weak var confirmNewPasswordTextField: GeneralTextField!

    var user: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func saveAction(_ sender: Any) {
        self.save()
    }

}

// MARK: - ViewDidLoad
extension ChangePasswordViewController {

    private func setUpData() {
        self.title = CHANGE_PASSWORD_TITLE
        self.user = UserDefaults.standard.getLocalUser()
        self.currentPasswordTextField.placeholder = CURRENT_PASS_TITLE
        self.currentPasswordTextField.isSecureText = true
        self.newPasswordTextField.placeholder = NEW_PASS_TITLE
        self.newPasswordTextField.isSecureText = true
        self.confirmNewPasswordTextField.placeholder = CONFIRM_NEW_PASS_TITLE
        self.confirmNewPasswordTextField.isSecureText = true
    }

    private func checkData() -> String? {
        if self.currentPasswordTextField.text.isEmpty || self.newPasswordTextField.text.isEmpty || self.confirmNewPasswordTextField.text.isEmpty {
            return PLEASE_ENTER_DATA_MESSAGE
        }
        if self.newPasswordTextField.text != confirmNewPasswordTextField.text {
            return MATCH_CONFIRM_NEW_PASS_MESSAGE
        }
        if self.currentPasswordTextField.text != user?.password {
            return CURRENT_PASS_VALIDATION_MESSAGE
        }
        if self.newPasswordTextField.text == currentPasswordTextField.text {
            return PASS_DIFFERENCE_VERIFICATION_MESSAGE
        }
        return nil
    }

    private func setNewPassword() {
        self.user?.password = self.newPasswordTextField.text
    }

    private func clearData() {
        self.currentPasswordTextField.text = ""
        self.newPasswordTextField.text = ""
        self.confirmNewPasswordTextField.text = ""
    }

    private func save() {
        if let errorMessage = checkData() {
            self._showErrorAlertOK(message: errorMessage)
            return
        }
        self.setNewPassword()
        UserController.shared.saveUser(userModel: self.user)
        self._showAlertOK(title: PASS_CHANGED_TITLE, message: CHANGED_SUCCESS_MESSAGE)
        self.clearData()
    }

}

