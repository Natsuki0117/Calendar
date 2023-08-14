//
//  NextViewItemControllerViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/07/12.
//

import UIKit
import RealmSwift

var items: [item] = []

class NextViewItemController: UIViewController {
    
    var date: Date!
    
    let realm = try! Realm()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var datetextField: UITextField!
    @IBOutlet var markSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
       datetextField.text = df.string(from: date)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(){
        let item = item()
        item.title = titleTextField.text ?? ""
        item.date = datetextField.text ?? ""
        item.isMarked = markSwitch.isOn
        createItem(item: item)
        if let presentingViewController = presentingViewController as? ViewController {
                   presentingViewController.items = presentingViewController.readItems()
                   presentingViewController.tableview.reloadData()
               }

//       画面遷移前のtableviewのデータとテーブルをリロード
        self.dismiss(animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createItem(item: item) {
        try! realm.write{
            realm.add(item)
        }
    }
}

