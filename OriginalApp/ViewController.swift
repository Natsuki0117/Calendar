//
//  ViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/06/21.
//
import UIKit
import RealmSwift
import FSCalendar

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableview: UITableView!
    @IBOutlet var calendar: FSCalendar!
    
    let df = DateFormatter()
    let realm = try! Realm()
    var items: [item] = []
    var date: Date!
    
    // 画面表示前に実行される処理
    override func viewWillAppear(_ animated: Bool) {
        items = readItems()
        tableview.reloadData()
   
}
    
    // 画面表示時に実行される処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        items = readItems()
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
        items = readItems()
        tableview.reloadData()
    }
    
    // テーブルビューの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // テーブルビューの各行に表示する内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item = items[indexPath.row]
        cell.setCell(title: item.title, date: item.date, isMarked: item.isMarked)
        return cell
    }
    
    // Realmからデータを取得
    func readItems() -> [item] {
        return Array(realm.objects(item.self))
    }
    
    // テーブルビューのアクションを設定
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Realmのデータを更新
            try! realm.write {
                let test = items.remove(at: indexPath.row)
                realm.delete(test)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    // アイテム追加ボタン押下時の処理(画面遷移)
    @IBAction func addItem(){
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "NewItem") as! NextViewItemController
        nextVC.date = self.date
        self.present(nextVC, animated: true, completion: nil)
    }
    
    //    tableviewへの表示
//    func filterModel() {
//        var filterdEvents: [[String:String]] = []
//        for ItemCell in item {
//            if eventModel["date"] == stringFromDate(date: selectedDate as Date, format: "yyyy.MM.dd") {
//                filterdEvents.append(eventModel)
//            }
//            var someStr: String?
//            guard let unwrapped = someStr else { return }
//            Print (unwrapped)
//        }
//      filterdModel = filterdEvents
//    }
  
    
}

    // 以下はFSCalendar関連のクラス拡張
//ここが日付を押した時の処理をしている
    extension ViewController: FSCalendarDataSource,
    FSCalendarDelegate {
func calendar(_ calendar: FSCalendar, didSelect
    date: Date, at monthPosition:
    FSCalendarMonthPosition) {
    self.date = date
        }
    }


