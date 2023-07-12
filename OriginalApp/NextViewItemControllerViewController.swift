//
//  NextViewItemControllerViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/07/12.
//

import UIKit
import RealmSwift

class NextViewItemControllerViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var datetextField: UITextField!
    @IBOutlet var markSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(){
        let item = item()
        item.title = titleTextField.text ?? ""
        item.date = datetextField.text ?? ""
        item.isMarked = markSwitch.isOn
        createItem(item: item)
        
        self.dismiss(animated: true)
    }
    
    func createItem(item: item) {
        try! realm.write{
            realm.add(item)
        }
    }


}
