//  Skaik_mo
//
//  MainNavigationViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import UIKit

class MainNavigationController: UINavigationController {

    let appearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDidLoad()
    }
}

// MARK: - ViewDidLoad
extension MainNavigationController {

    private func setupViewDidLoad() {
        AppDelegate.shared?.rootNavigationController = self
        setRoot()
        self.color = color_Black
    }
    
}

extension MainNavigationController {

    private func setRoot() {
        let vc: LaunchViewController = LaunchViewController._instantiateVC()
        vc._rootPush()
    }
    
}

extension UINavigationController {

    var backgroundColorWhenScroll: UIColor {
        set {
            self.navigationBar.barTintColor = newValue
        }
        get {
            return .clear
        }
    }

    var color: UIColor {
        set {
            self.setProperties(color: newValue)
        }
        get {
            return .clear
        }
    }

    private func setProperties(color: UIColor) {

        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: fontQuicksandBold22 ?? UIFont.systemFont(ofSize: 10, weight: .regular)]

        if #available(iOS 13, *) {

            let standardAppearance = UINavigationBarAppearance()

            standardAppearance.configureWithTransparentBackground()

            // title
            standardAppearance.titleTextAttributes = titleTextAttributes

            self.navigationBar.standardAppearance = standardAppearance
            self.navigationBar.scrollEdgeAppearance = standardAppearance
        } else {

            self.navigationBar.titleTextAttributes = titleTextAttributes
        }

        self.navigationBar.topItem?.backButtonTitle = ""
        self.navigationBar.tintColor = color
    }
}
