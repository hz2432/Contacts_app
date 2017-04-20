//
//  DetailViewController.swift
//  Contacts
//
//  Created by haiki on 4/20/17.
//  Copyright © 2017 haiki. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    
    var person: Person?
    
    var completionCallBAck: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if person != nil {
            nameText.text = person?.name
            phoneText.text = person?.phone
            titleText.text = person?.title
        }
    }
//change data
    @IBAction func savePerson(_ sender: Any) {
        // judge person nil or not
        
        if person == nil {
            person = Person()
        }
        
        person?.name = nameText.text
        person?.phone = phoneText.text
        person?.title = titleText.text
        
        //run closure
        completionCallBAck?()
        
        //return
        navigationController?.popViewController(animated: true)
    }
}
