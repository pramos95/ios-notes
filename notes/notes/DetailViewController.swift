//
//  DetailViewController.swift
//  notes
//
//  Created by Pedro Ramos on 7/26/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit

@objc class DetailViewController: UIViewController {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var content: UITextView!
    
    @objc public var note: Note?
    @objc public var category: NoteCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let note = note else {
            return
        }
        noteTitle.text = note.title
        createdDate.text = HelperClass.formatDate(date: note.contentDate)
        categoryTitle.text = category?.title
        content.text = note.content
    }

}
