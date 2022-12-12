//  Skaik_mo
//
//  NotesViewController.swift
//  Notes
//
//  Created by Mohammed Skaik on 07/12/2022.
//

import UIKit

class NotesViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: GeneralTableView!
    var category: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpData()
        self.fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }

    @IBAction func addAction(_ sender: Any) {
        let vc: AddOrEditViewController = AddOrEditViewController._instantiateVC()
        vc.typeView = .AddNote
        vc.category = self.category
        vc._push()
    }

}

// MARK: - ViewDidLoad
extension NotesViewController {

    private func setUpView() {
        self.setUpTableView()
    }

    private func setUpData() {
        if let category {
            self.title = category.title
        }
    }

    private func fetchData() {
        if let category {
            self.tableView.resetTableView(objects: NoteController.shared.fetchNotesByCategory(category: category))
        }
    }

    private func setUpTableView() {
        self.tableView.contentInset = UIEdgeInsets.init(top: 25, left: 0, bottom: 10, right: 0)
        self.tableView.cell = NoteTableViewCell.self
//        self.tableView.cellHeight = 125
        self.tableView.emptyImage = ic_noNotes
        self.tableView.titleEmpty = NO_NOTES_TITLE
    }

}

extension GeneralTableView {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard AppDelegate.shared?._topVC is NotesViewController else { return nil }
        let action: UIContextualAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            if let note = self.objects[indexPath.item] as? Note, let id = note.id {
                if NoteController.shared.deleteNoteByID(id: id) {
                    self.objects.remove(at: indexPath.item)
                    self.deleteRows(at: [indexPath], with: .automatic)
                }
            }
            completionHandler(true)
        }
        action.image = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        action.backgroundColor = UIColor.systemRed
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }

}
