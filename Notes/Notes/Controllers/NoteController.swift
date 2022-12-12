//
//  NoteController.swift
//  Notes
//
//  Created by Mohammed Skaik on 07/12/2022.
//

import Foundation
import MagicalRecord

class NoteController {

    static let shared = NoteController()

    func saveNote(category: Category?, note: Note?, title: String?, description: String?, status: Bool?) {
        guard let category else { return }
        var id = UUID()
        if let note, let _id = note.id {
            id = _id
        }
        let note = Note.mr_findFirstOrCreate(byAttribute: "id", withValue: id)
        note.title = title
        note.descriptionNote = description
        note.category = category
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }

    func fetchNotesByCategory(category: Category?) -> [Note] {
        guard let category else { return [] }
        return Note.mr_find(byAttribute: "category", withValue: category) as? [Note] ?? []
    }

    func getDoneAndWaitingNotes(categories: [Category]) -> (doneNotes: Int, waitingNotes: Int) {
        guard !categories.isEmpty else { return (0, 0) }
        var doneNotes = 0
        var waitingNotes = 0
        categories.forEach { category in
            let notes = Note.mr_find(byAttribute: "category", withValue: category) as? [Note]
            notes?.forEach({ note in
                if note.status {
                    doneNotes += 1
                } else {
                    waitingNotes += 1
                }
            })
        }

        return (doneNotes, waitingNotes)
    }

    func deleteNoteByID(id: UUID) -> Bool {
        let isDeleted = Note.mr_deleteAll(matching: NSPredicate(format: "id = %@", id.uuidString))
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        return isDeleted
    }

    func deleteNoteByCategory(category: Category) -> Bool {
        let isDeleted = Note.mr_deleteAll(matching: NSPredicate(format: "category = %@", category))
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        return isDeleted
    }

}
