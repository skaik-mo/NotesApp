//  Skaik_mo
//
//  Helper.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import Foundation

import ProgressHUD

class Helper {

    class func showIndicator(_ isShowIndicator: Bool = true) {
        if isShowIndicator {
            ProgressHUD.showIndicator()
        }
    }

    class func dismissIndicator(_ isShowIndicator: Bool = true) {
        if isShowIndicator {
            ProgressHUD.dismissIndicator()
        }
    }
    
    class func _showAlert(title: String = ALERT_TITLE, message: String?, buttonTitle1: String = OK_TITLE, buttonTitle2: String = CANCEL_TITLE, buttonAction1: @escaping (() -> Void), buttonAction2: (() -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: buttonTitle1, style: .default) { action in
            debugPrint("Okay aciton is pressed")
            buttonAction1()
        }
        let cancelAction = UIAlertAction.init(title: buttonTitle2, style: .cancel) { action in
            debugPrint("Cancel aciton is pressed")
            buttonAction2?()
        }
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        alert._presentVC()
    }
}
