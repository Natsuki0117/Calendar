//
//  ViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/06/21.
//

import UIKit
import RealmSwift
import FSCalendar

class ViewController: UIViewController, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        let item: item = items[indexPath.row]
        
        cell.setCell(title: item.title, date: item.date, isMarked: item.isMarked)
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath as IndexPath) as! ItemTableViewCell
        let _: item = items[indexPath.row]
        //            cell.setCell(title: item.title, date: item.date, isMarked: item.isMarked)
        
        return cell
        
    }
    
    func readItems() -> [item] {
        return Array(realm.objects(item.self))
    }
  
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // realmのデータを更新
            
        }
        
        
    }
    

    self.tableview.deleteRows(at: <#T##[IndexPath]#>, with: .automatic)
  
}
