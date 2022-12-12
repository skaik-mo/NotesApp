//  Skaik_mo
//
//  L102Localizer.swift
//  Notes
//
//  Created by Mohammed Skaik on 10/12/2022.
//

import Foundation
import UIKit

class L102Localizer: NSObject {

    class func DoTheMagic() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey: value: table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_: value: table:)))
        MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.cstmlayoutSubviews))
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
        MethodSwizzleGivenClassName(cls: UIView.self, originalSelector: #selector(UIView.layoutSubviews), overrideSelector: #selector(UIView.customlayoutSubviews))
    }
}

extension UILabel {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            return // handle special case with uitextfields
        }
        if self.tag <= 0 {
            if Language.shared.isRTL {
                if self.textAlignment == .right {
                    return
                }
            } else {
                if self.textAlignment == .left {
                    return
                }
            }
        }
        if self.tag <= 0 {
            if self.textAlignment != .center {
                if Language.shared.isRTL {
                    self.textAlignment = .right
                } else {
                    self.textAlignment = .left
                }
            }
        }
    }
}


extension UITextField {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.tag <= 0 {
            if self.textAlignment != .center {
                if Language.shared.isRTL {
                    if self.textAlignment == .right { return }
                    self.textAlignment = .right
                } else {
                    if self.textAlignment == .left { return }
                    self.textAlignment = .left
                }
            }
        }
    }
}

extension UIView {
    @objc public func customlayoutSubviews() {
        self.customlayoutSubviews()
        if self.tag <= 0 {
            if Language.shared.isRTL {
                self.semanticContentAttribute = .forceRightToLeft
            } else {
                self.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
}

var numberoftimes = 0
extension UIApplication {
    @objc var cstm_userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if Language.shared.currentAppleLanguage() == "ar" {
                direction = .rightToLeft
            }
            return direction
        }
    }
}

extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            let currentLanguage = Language.shared.currentAppleLanguage()
            var bundle = Bundle();
            if let _path = Bundle.main.path(forResource: Language.shared.currentAppleLanguageFull(), ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } else
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } else {
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

func disableMethodSwizzling() {

}

// Exchange the implementation of two methods of the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

