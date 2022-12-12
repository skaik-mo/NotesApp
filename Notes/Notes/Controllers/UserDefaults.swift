//  Skaik_mo
//
//  UserDefaults.swift
//  Notes
//
//  Created by Mohammed Skaik on 06/12/2022.
//

import Foundation

extension UserDefaults {

    func saveLocalUser(userModel: UserModel) {
        let data = try? JSONSerialization.data(withJSONObject: userModel.getDictionary(), options: .fragmentsAllowed)
        self.setValue(data, forKey: "USER")
        self.synchronize()
    }

    func getLocalUser() -> UserModel? {
        let data = self.value(forKey: "USER") as? Data
        if let _data = data {
            let dictionary = try? JSONSerialization.jsonObject(with: _data, options: .fragmentsAllowed) as? [String: Any?]
            return UserModel.init(dictionary: dictionary)
        }
        return nil
    }

    func clearUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            self.removePersistentDomain(forName: appDomain)
        }
    }

}









