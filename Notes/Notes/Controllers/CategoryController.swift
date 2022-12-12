//
//  CategoryController.swift
//  Notes
//
//  Created by Mohammed Skaik on 07/12/2022.
//

import Foundation
import MagicalRecord

class CategoryController {

    static let shared = CategoryController()

    func saveCategory(category: Category?, title: String?, description: String?) {
        var id = UUID()
        if let category, let _id = category.id {
            id = _id
        }
        let category = Category.mr_findFirstOrCreate(byAttribute: "id", withValue: id)
        category.title = title
        category.descriptionCategory = description
        category.user = UserController.shared.fetchUser(email: UserDefaults.standard.getLocalUser()?.email)
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }

    func fetchCategories() -> [Category] {
        guard let user = UserController.shared.fetchUser(email: UserDefaults.standard.getLocalUser()?.email) else { return [] }
        return Category.mr_find(byAttribute: "user", withValue: user) as? [Category] ?? []
    }

    func deleteCategory(id: UUID) -> Bool {
        let isDeleted = Category.mr_deleteAll(matching: NSPredicate(format: "id = %@", id.uuidString))
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        return isDeleted
    }

}

