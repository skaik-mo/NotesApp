//
//  GeneralButton.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import UIKit

class GeneralButton: UIButton {

    var corner: CGFloat = -1

    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = self.corner == -1 ? self.frame.height / 2 : self.corner
        self.backgroundColor = color_6A90F2
        self.shadowColor = UIColor.black.withAlphaComponent(0.2)
        self.shadowOffset = CGSize.init(width: 0, height: 14)
        self.shadowRadius = 24
        self.shadowOpacity = 1

        self.titleLabel?.font = fontRobotoMedium20
        self.setTitleColor(color_White, for: .normal)
        self.setTitle(self.currentTitle?._localizedKey, for: .normal)
    }

}
