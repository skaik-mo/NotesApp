//  Skaik_mo
//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Mohammed Skaik on 07/12/2022.
//

import UIKit

class NoteTableViewCell: GeneralTableViewCell {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configerCell() {
        if let note = self.object as? Note {
            self.checkButton.isSelected = note.status
            self.titleLabel.text = note.title
            self.descriptionLabel.text = note.descriptionNote
        }

    }

    @IBAction func checkAction(_ sender: Any) {
        guard let note = self.object as? Note else { return }
        note.status.toggle()
        self.checkButton.isSelected = note.status
        NoteController.shared.saveNote(category: note.category, note: note, title: note.title, description: note.descriptionNote, status: note.status)
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: AddOrEditViewController = AddOrEditViewController._instantiateVC()
        vc.typeView = .EditNote
        let note = self.object as? Note
        vc.category = note?.category
        vc.note = note
        vc._push()
    }

}
