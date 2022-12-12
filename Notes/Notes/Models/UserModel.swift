//
//  UserModel.swift
//  Notes
//
//  Created by Mohammed Skaik on 05/12/2022.
//

import Foundation

class UserModel {
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    var password: String?

    init(firstName: String? = nil, lastName: String? = nil, email: String?, phone: String? = nil, password: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email?.lowercased()
        self.phone = phone
        self.password = password
    }

    init?(dictionary: [String: Any?]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.firstName = dictionary["firstName"] as? String
        self.lastName = dictionary["lastName"] as? String
        self.email = dictionary["email"] as? String
        self.phone = dictionary["phone"] as? String
        self.password = dictionary["password"] as? String
    }

    func getDictionary() -> [String: Any?] {
        let dictionary: [String: Any?] = [
            "firstName": self.firstName,
            "lastName": self.lastName,
            "email": self.email,
            "phone": self.phone,
            "password": self.password,
        ]
        return dictionary
    }

    func setUser(_ user: User) {
        user.firstName = self.firstName
        user.lastName = self.lastName
        user.email = self.email
        user.phone = self.phone
        user.password = self.password
    }

}
