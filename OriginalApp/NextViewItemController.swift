//
//  NextViewItemControllerViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/07/12.
//

import UIKit
import RealmSwift

class NextViewItemController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var datetextField: UITextField!
    @IBOutlet var detailTextView: UITextView!
    
    
    let realm = try! Realm()
    var date: Date!
    var items: [item] = []
    var event: item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        datetextField.text = df.string(from: date)
    }
    
    @IBAction func save(){
        let item = item()
        item.title = titleTextField.text ?? ""
        item.date = datetextField.text ?? ""
        item.detail = detailTextView.text ?? ""
        
        createItem(item: item)
        let nav = self.presentingViewController as! UINavigationController
        let prevVC = nav.viewControllers.last as! ViewController
        prevVC.calendar.reloadData()
        prevVC.items = prevVC.readItems()
        prevVC.tableview.reloadData()
        self.dismiss(animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func createItem(item: item) {
        try! realm.write{
            realm.add(item)
        }
    }
    let textColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        // ダークモードの場合
        if traitCollection.userInterfaceStyle == .dark {
            return .white
        } else {
            return .blue
        }
    }
    
}
