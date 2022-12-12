//
//  SettingModel.swift
//  Notes
//
//  Created by Mohammed Skaik on 09/12/2022.
//

import Foundation
import UIKit

enum Setting: Int {
    case Language, Profile, ChangePassword, AboutApp, Logout

}

class SettingModel {
    let icon: UIImage?
    let title: String
    let subTitle: String
    let setting: Setting

    init(icon: UIImage?, title: String, subTitle: String, setting: Setting) {
        self.icon = icon
        self.title = title
        self.subTitle = subTitle
        self.setting = setting
    }


    func action() {
        switch self.setting {
        case .Language:
            Language.shared.selectLanguageAlert()
        case .Profile:
            let vc: ProfileViewController = ProfileViewController._instantiateVC()
            vc._push()
        case .ChangePassword:
            let vc: ChangePasswordViewController = ChangePasswordViewController._instantiateVC()
            vc._push()
        case .AboutApp:
            let vc: AboutAppViewController = AboutAppViewController._instantiateVC()
            vc._push()
        case .Logout:
            UserController.shared.logout()
        }
    }
}
