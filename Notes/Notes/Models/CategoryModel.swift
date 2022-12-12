//
//  CategoryModel.swift
//  Notes
//
//  Created by Mohammed Skaik on 07/12/2022.
//

import Foundation

class CategoryModel {
    var id: UUID?
    var title: String?
    var descriptionCategory: String?

    init(id: UUID? = nil, title: String? = nil, descriptionCategory: String? = nil) {
        self.id = id
        self.title = title
        self.descriptionCategory = descriptionCategory
    }

    func setCategory(_ category: Category) {
        category.id = self.id
        category.title = self.title
        category.descriptionCategory = self.descriptionCategory
        category.user = UserController.shared.fetchUser(email: UserDefaults.standard.getLocalUser()?.email)
    }
    

}
