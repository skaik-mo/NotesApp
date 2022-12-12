//
//  UserController.swift
//  Notes
//
//  Created by Mohammed Skaik on 05/12/2022.
//

import Foundation
import MagicalRecord

extension User {

    func asUserModel() -> UserModel {
        return UserModel(firstName: self.firstName, lastName: self.lastName, email: self.email, phone: self.phone, password: self.password)
    }

}

class UserController {

    static let shared = UserController()

    func saveUser(userModel: UserModel?) {
        guard let userModel, let email = userModel.email else { return }
        let user = User.mr_findFirstOrCreate(byAttribute: "email", withValue: email)
        userModel.setUser(user)
        UserDefaults.standard.saveLocalUser(userModel: userModel)
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }

    func fetchUser(email: String?) -> User? {
        guard let email = email else { return nil }
        return User.mr_find(byAttribute: "email", withValue: email)?.first as? User

    }

    func signUp(userModel: UserModel) -> String? {
        Helper.showIndicator()
        if let user = self.fetchUser(email: userModel.email), let email = user.email {
            Helper.dismissIndicator()
            return EMAIL_SPACE_MESSAGE + email + ALREADY_EXSIST_MESSAGE
        }
        self.saveUser(userModel: userModel)
        Helper.dismissIndicator()
        return nil
    }


    func login(userModel: UserModel) -> String? {
        Helper.showIndicator()
        guard let user = self.fetchUser(email: userModel.email) else {
            Helper.dismissIndicator()
            return COULD_NOT_FIND_YOUR_EMAIL_MESSAGE
        }
        if userModel.password == user.password {
            // The data is correct, so you can log in
            UserDefaults.standard.saveLocalUser(userModel: user.asUserModel())
            Helper.dismissIndicator()
            return nil
        }
        Helper.dismissIndicator()
        return PASS_VALIDATION_MESSAGE
    }

    func logout() {
        Helper._showAlert(message: CONFIRM_LOGOUT_MESSAGE) {
            let lang = Language.shared.currentAppleLanguage()
            UserDefaults.standard.clearUserDefaults()
            Language.shared.setAppleLAnguageTo(lang: lang)
            let vc: LoginViewController = LoginViewController._instantiateVC()
            vc._rootPush()
        }
    }

}
