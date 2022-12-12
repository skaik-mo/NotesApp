//  Skaik_mo
//
//  LaunchViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import UIKit

class LaunchViewController: UIViewController {

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self._isHideNavigation = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

}

// MARK: - ViewDidLoad
extension LaunchViewController {

    private func setUpView() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(goToTabBar), userInfo: nil, repeats: false)

    }

    @objc private func goToTabBar() {
        if UserDefaults.standard.getLocalUser() == nil {
            let vc: LoginViewController = LoginViewController._instantiateVC()
            vc._push()
        } else {
            let vc: CategoriesViewController = CategoriesViewController._instantiateVC()
            vc._rootPush()
        }
    }

}
