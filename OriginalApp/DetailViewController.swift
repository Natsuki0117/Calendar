//
//  DetailViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/08/30.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
   @IBOutlet  var todo: String!
   @IBOutlet var detail: String!

    let realm = try! Realm()
var item: item? // ItemはRealmのモデルオブジェクトの想定です
    
 
    @IBAction func back() {
        self.dismiss(animated: true)
    }

}
