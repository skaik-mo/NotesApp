//  Skaik_mo
//
//  AboutAppViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 10/12/2022.
//

import UIKit

class AboutAppViewController: UIViewController {

    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - ViewDidLoad
extension AboutAppViewController {

    private func setUpData() {
        self.title = ABOUT_APP_TITLE
        
    }

}
