//  Skaik_mo
//
//  ActivityIndicator.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import Foundation
import ProgressHUD

extension ProgressHUD {

    class func showIndicator() {
        ProgressHUD.show(interaction: false)
        ProgressHUD.colorAnimation = color_6A90F2
        ProgressHUD.animationType = .circleSpinFade
//        ProgressHUD.showProgress(<#T##progress: CGFloat##CGFloat#>)
    }

    class func dismissIndicator() {
        ProgressHUD.dismiss()
    }
}
