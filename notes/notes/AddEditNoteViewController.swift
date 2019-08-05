//
//  AddEditNoteViewController.swift
//  notes
//
//  Created by Pedro Ramos on 7/26/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit

class AddEditNoteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var categoriesPicker: UIPickerView!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var content: UITextView!
    
    @objc public weak var note: Note?
    @objc public var categories: [NoteCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = ModelController.sharedInstance().getCategories()
        
        guard let note = note else {
            return
        }
        var catIndex = 0
        while (catIndex < categories!.count) {
            if (categories![catIndex].categoryId.isEqual(to: note.categoryId)) {
                break
            }
            catIndex += 1
        }
        
        self.categoriesPicker.selectRow(catIndex, inComponent: 0, animated: true)
        noteTitle.text = note.title
        content.text = note.content
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let cat = categories else {
            return 0
        }
        return cat.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let cat = categories else {
            return nil
        }
        return cat[row].title
    }

    @IBAction func readyForUpdateNoteData(_ sender: UIButton) {
        guard let cat = categories else {
            return
        }
        let cont = ModelController.sharedInstance()
        if (noteTitle.text == "") {
            let alert = UIAlertController(title: "Empty note title", message: "Note title cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Discard note", style: .destructive, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Continue editing", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        if let note = note { //The note is loaded then the action is edit
            let newNote = Note.init(id: "", title: noteTitle.text!, content: content.text, contentDate: note.contentDate, categoryId: cat[categoriesPicker.selectedRow(inComponent: 0)].categoryId)
            cont.edit(note, withModifiedNote: newNote)
        } else {
            let newNote = Note.init(id: "", title: noteTitle.text!, content: content.text, contentDate: Date(), categoryId: cat[categoriesPicker.selectedRow(inComponent: 0)].categoryId)
            cont.add(newNote)
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
}
