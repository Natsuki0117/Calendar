//
//  ViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/06/21.
//
import UIKit
import RealmSwift
import FSCalendar

class ViewController: UIViewController, UITableViewDataSource, FSCalendarDataSource,FSCalendarDelegate {
    
    @IBAction func addItem(){
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "NewItem") as! NextViewItemController
        nextVC.date = self.date
        self.present(nextVC, animated: true, completion: nil)
        
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
    
    
    
    
    
    
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var calendar: FSCalendar!
    
    var realm = try! Realm()
    var items: [item] = []
    var label:UILabel!
    let df = DateFormatter()
    let fscCalendar = FSCalendar()
    
    var date: Date!
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        df.dateFormat = "yyyy/MM/dd"
        label.text = df.string(from: date)
        self.date = date
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        tableview.dataSource = self
        tableview.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        items = readItems()
        
        self.calendar.dataSource = self
        self.calendar.delegate = self
        
        
        _ = calendar
        self.calendar
        
        let results = realm.objects(item.self)
        
        let count = results.count
        if (count == 0) {
            
        } else {
            
            for result in results {
                print("\(String(describing: result.isSameObject(as: )))")
            }
            
            for i in 0 ..< count {
                print("\(String(describing: results[i].isSameObject(as: )))")
            }
        }
        
       
        
        func viewWillAppear(_ animated: Bool) {
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
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                //             realmのデータを更新
                try! realm.write {
                    let test = items.remove(at: indexPath.row)
                    realm.delete(test)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
        
        
        
    }
}
