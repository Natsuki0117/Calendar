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
    var displayedEvents: [item] = [] // 表示するイベントを保持する配列
    
    // 画面が表示される直前にtableViewを更新
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }
//
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
        return displayedEvents.count // displayedEventsの数を返すように変更
    }
    
    // テーブルビューの各行に表示する内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item = displayedEvents[indexPath.row] // displayedEventsからデータを取得するように変更
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
                let test = displayedEvents.remove(at: indexPath.row) // displayedEventsから削除
                realm.delete(test)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    // アイテム追加ボタン押下時の処理(画面遷移)
    @IBAction func addItem() {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "NewItem") as! NextViewItemController
        nextVC.date = self.date
        self.present(nextVC, animated: true, completion: nil)
    }
}

// 以下はFSCalendar関連のクラス拡張
extension ViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = date
        
        // 日付が一致するイベントを取得
        //        let eventsForDate = getEvents(for: date)
        //
        // テーブルビューに表示するイベントを更新
        //        displayedEvents = eventsForDate
        //        tableview.reloadData()
        //    }
        //
        //    // 日付に対応するイベントをフィルタリングして取得
        //    func getEvents(for date: Date) -> [item] {
        //        return items.filter { $0.date == date }
        //    }
    }
    
}
