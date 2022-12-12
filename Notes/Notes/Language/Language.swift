//  Skaik_mo
//
//  Language.swift
//  Notes
//
//  Created by Mohammed Skaik on 10/12/2022.
//

import UIKit

class Language {

    static let shared = Language()

    let APPLE_LANGUAGE_KEY = "AppleLanguages"

    var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }

    var currentLanguageKey: String? {
        let langs = UserDefaults.standard.value(forKey: APPLE_LANGUAGE_KEY) as? Array<String>
        return (langs?.first)
    }

    // get current Apple language
    func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current.substring(to: current.index(endIndex, offsetBy: 2))
        return currentWithoutLocale
    }

    func currentAppleLanguageFull() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }

    // set @lang to be the first in Applelanguages list
    func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang, currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }

    func selectLanguageAlert() {
        let alertController = UIAlertController.init(title: SELECT_YOUR_DEFAULT_LANGUAGE_TITLE, message: "", preferredStyle: .actionSheet)
        let englishAction = UIAlertAction(title: "English", style: .default) { _ in
            Helper._showAlert(message: CONFIRM_CHANGE_LANGUAGE) {
                self.setAppleLAnguageTo(lang: "en")
                exit(0)
            }
        }
        let arabicAction = UIAlertAction(title: "Arabic (اللغة العربية)", style: .default) { _ in
            Helper._showAlert(message: CONFIRM_CHANGE_LANGUAGE) {
                self.setAppleLAnguageTo(lang: "ar")
                exit(0)
            }
        }
        let cancelAction = UIAlertAction(title: CANCEL_TITLE, style: .cancel)
        alertController.addAction(englishAction)
        alertController.addAction(arabicAction)
        alertController.addAction(cancelAction)
        alertController._presentVC()
    }


}
