//  Skaik_mo
//
//  UIViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import Foundation
import UIKit

// MARK: - Transfers Shortcuts
extension UIViewController {

    var _topMostViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?._topMostViewController
        }
        else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController._topMostViewController
            }
            return tabBarController._topMostViewController
        }

        else if let presentedViewController = self.presentedViewController {
            return presentedViewController._topMostViewController
        }

        else {
            return self
        }
    }

    class var _mainStoryboard: UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }

    class func _instantiateVC<T: UIViewController>() -> T {
        guard let vc = self._mainStoryboard.instantiateVC(withIdentifier: self._id) as? T else {
            fatalError("Couldn't find UIViewController for \(self._id), make sure the view controller is created")
        }
        return vc
    }

    func _rootPush() {
        AppDelegate.shared?.rootNavigationController?.setViewControllers([self], animated: true)
    }

    func _push() {
        AppDelegate.shared?.rootNavigationController?.pushViewController(self, animated: true)
    }

    func _presentVC() {
        AppDelegate.shared?.rootNavigationController?.present(self, animated: true, completion: nil)
    }

    func _pop() {
        AppDelegate.shared?.rootNavigationController?.popViewController(animated: true)
    }

    func _dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func _popViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func _popViewControllerWithoutAnimated(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

    @IBAction func _dismissViewController(_ sender: Any) {
        self._dismissVC()
    }

    @IBAction func _dismissViewControllerWithoutAnimated(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}

// MARK: - Alerts Shortcuts
extension UIViewController {
    func _showAlertOK(title: String = ALERT_TITLE, message: String?, okButtonAction: (() -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: OK_TITLE, style: .default) { action in
            okButtonAction?()
        }
        alert.addAction(okayAction)
        alert._presentVC()
    }

    func _showErrorAlertOK(title: String = ERROR_TITLE, message: String?, okButtonAction: (() -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: OK_TITLE, style: .destructive) { action in
            okButtonAction?()
        }

        alert.addAction(okayAction)
        alert._presentVC()
    }

    func _showAlert(title: String = ALERT_TITLE, message: String?, buttonTitle1: String = OK_TITLE, buttonTitle2: String = CANCEL_TITLE, buttonAction1: @escaping (() -> Void), buttonAction2: (() -> Void)?) {
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

    func sharing(items: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController._presentVC()
    }

}

extension UIViewController {

    var _getStatusBarHeightBottom: CGFloat? {
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom
    }

    var _getStatusBarHeightTop: CGFloat? {
        return UIApplication.shared.keyWindow?.safeAreaInsets.top
    }

    var _screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    var _screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    var _isHideNavigation: Bool {
        set {
            self.navigationController?.setNavigationBarHidden(newValue, animated: true)
        }
        get {
            return self.navigationController?.isNavigationBarHidden ?? false
        }
    }

    func _emptyImgaeNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .top, barMetrics: .default)
    }

    func _nilImgaeNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }

    func _setTitleBackBarButton() {
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationBar.tintColor = color_Black
    }

}
