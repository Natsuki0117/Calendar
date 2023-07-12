//
//  ViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/06/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
  
    
    
    @IBOutlet var tableview: UITableView!
    
    
    let realm = try! Realm()
    var items: [item] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableview.dataSource = self
        tableview.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        items = readItems()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items = readItems()
        tableview.reloadData()
    }
    

        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath as IndexPath) as! TableViewCell
            let _: item = items[indexPath.row]
//            cell.setCell(title: item.title, date: item.date, isMarked: item.isMarked)
            
            return cell
           
        }
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func readItems() -> [item] {
        return Array(realm.objects(item.self))
    }
        
    }
