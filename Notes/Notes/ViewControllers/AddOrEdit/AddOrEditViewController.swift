//  Skaik_mo
//
//  AddOrEditViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 07/12/2022.
//

import UIKit

class AddOrEditViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleTextField: GeneralTextField!
    @IBOutlet weak var descriptionTextField: GeneralTextField!

    var note: Note?
    var category: Category?

    enum TypeView {
        case AddCategory
        case EditCategory
        case AddNote
        case EditNote
    }
    var typeView: TypeView = .AddCategory

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpData()
        self.fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func saveAction(_ sender: Any) {
        self.save()
    }

}

// MARK: - ViewDidLoad
extension AddOrEditViewController {

    private func setUpView() {

    }

    private func setUpData() {
        self.title = ""
        self.setUpDataTypeView()
        self.titleTextField.placeholder = TITLE
        self.descriptionTextField.placeholder = DESCRIPTION_TITLE
    }

    private func fetchData() {

    }

    private func setUpDataTypeView() {
        switch self.typeView {
        case .AddCategory:
            self.titleLabel.text = NEW_CATEGORY_TITLE
            self.subTitleLabel.text = CREATE_CATEGORY_TITLE
        case .EditCategory:
            self.titleLabel.text = EDIT_CATEGORY_TITLE
            self.subTitleLabel.text = ""
            if let category {
                self.titleTextField.text = category.title ?? ""
                self.descriptionTextField.text = category.descriptionCategory ?? ""
            }
        case .AddNote:
            self.titleLabel.text = NEW_NOTE_TITLE
            self.subTitleLabel.text = CREATE_NOTE_TITLE
        case .EditNote:
            self.titleLabel.text = EDIT_NOTE_TITLE
            self.subTitleLabel.text = ""
            if let note {
                self.titleTextField.text = note.title ?? ""
                self.descriptionTextField.text = note.descriptionNote ?? ""
            }
        }
    }

}

extension AddOrEditViewController {

    private func checkData() -> Bool {
        if self.titleTextField.text.isEmpty || self.descriptionTextField.text.isEmpty {
            self._showErrorAlertOK(message: PLEASE_ENTER_DATA_MESSAGE)
            return false
        }
        return true
    }

    private func saveCategory() {
        CategoryController.shared.saveCategory(category: category, title: self.titleTextField.text, description: self.descriptionTextField.text)
    }

    private func saveNote() {
        NoteController.shared.saveNote(category: category, note: note, title: self.titleTextField.text, description: self.descriptionTextField.text, status: note?.status)
    }


    private func save() {
        guard self.checkData() else { return }
        switch self.typeView {
        case .AddCategory, .EditCategory:
            self.saveCategory()
            break
        case .AddNote, .EditNote:
            self.saveNote()
            break
        }
        self._pop()
    }

}
