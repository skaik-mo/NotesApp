//  Skaik_mo
//
//  GeneralTextField.swift
//  Notes
//
//  Created by Mohammed Skaik on 04/12/2022.
//

import UIKit

class GeneralTextField: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: UITextField!

    var placeholder: String? {
        set {
            self.textField.placeholder = newValue
            self.setAttributedPlaceholder()
        }
        get {
            return textField.placeholder
        }
    }

    var keyboardType: UIKeyboardType {
        set {
            self.textField.keyboardType = newValue
        }
        get {
            return .default
        }
    }

    var isSecureText: Bool {
        set {
            self.textField.isSecureTextEntry = newValue
        }
        get {
            return false
        }
    }

    var text: String {
        set {
            self.textField.text = newValue
        }
        get {
            return self.textField.text ?? ""
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureXib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureXib()
    }

    private func configureXib() {
        Bundle.main.loadNibNamed(GeneralTextField._id, owner: self, options: [:])
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.layoutIfNeeded()
    }

    func setAttributedPlaceholder() {
        self.textField.attributedPlaceholder = NSAttributedString(
            string: self.textField.attributedPlaceholder?.string ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: color_9391A4, NSAttributedString.Key.font: fontRobotoLight22 ?? UIFont.systemFont(ofSize: 22, weight: .light)]
        )
    }

}
