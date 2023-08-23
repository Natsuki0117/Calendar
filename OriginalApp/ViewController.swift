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
    var displayedItems: [item] = [] // 表示するイベントを保持する配列
    
    // 画面表示時に実行される処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        items = readItems()
        tableview.reloadData()
    }
    
    // テーブルビューの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedItems.count // displayedItemsの数を返すように変更
    }
    
    // テーブルビューの各行に表示する内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item = displayedItems[indexPath.row] // displayedEventsからデータを取得するように変更
        cell.setCell(title: item.title, date: item.date, isMarked: item.isMarked)
        return cell
    }
    
//    セルをタップした時に行番号を出力
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
var alertController = UIAlertController()
        alertController = UIAlertController(title: "タイトル", message: "イベント",preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancel)
    }
    
    
    // Realmからデータを取得
    func readItems() -> [item] { // 引数にdateを取る
        return Array(realm.objects(item.self)) // Realmのデータのうちdateが一致するものを取得して返す
    }
    
    // テーブルビューのアクションを設定
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Realmのデータを更新
            try! realm.write {
                let item = displayedItems.remove(at: indexPath.row) // displayedItemsから削除
                realm.delete(item)
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
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        // ① item.dateがdateと一致するデータを取得してdisplayedItemsに代入する
        displayedItems = Array(realm.objects(item.self).filter("date == %@", df.string(from: date)))
        // ② tableViewの表示内容を更新する
        tableview.reloadData()
    }
}
