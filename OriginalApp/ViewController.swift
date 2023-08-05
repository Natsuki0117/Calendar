//
//  ViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/06/21.
//

import UIKit
import RealmSwift
import FSCalendar

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FSCalendarDataSource,FSCalendarDelegate {
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var calendar: FSCalendar!
    
    var realm = try! Realm()
    var items: [item] = []
    
    var date: Date!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        items = readItems()
        
        self.calendar.dataSource = self
        self.calendar.delegate = self
        
        let test = calendar
        self.calendar
        // 全件検索します。
        let results = realm.objects(item.self)
        
        // 検索結果の件数を取得します。
        let count = results.count
        if (count == 0) {
            // 検索データ0件の場合
            
            
        } else {
            // 検索データがある場合
            
            // コレクションとしてアクセスする場合
            // resultは"item"クラスとしてアクセスできます。
            for result in results {
                print("\(String(describing: result.isSameObject(as: )))")
                
                
            }
            
            // インデックスを指定してアクセスする場合
            // results[i]は"item"クラスとしてアクセスできます。
            for i in 0 ..< count {
                print("\(String(describing: results[i].isSameObject(as: )))")
            }
            
            //                エラー処理必要
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = date
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
    
    func addItem(){
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "NewItem") as! NextViewItemController
        nextVC.date = date
        self.present(nextVC, animated: true)
        
    }
}
