import UIKit
import SwiftUI
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
        cell.setCell(title: item.title, date: item.date)
        return cell
    }
    
    // セルをタップした時に行番号を出力
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customCell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
        let titleText = customCell.titlelabel.text // カスタムセルからtitletextを取得
        let dateText = customCell.datelabel.text //タイトルにdateを代入
        if let item = realm.objects(item.self).filter("title == %@", titleText).first {
            // item オブジェクトから詳細情報を取得
            let detailText = item.detail
            
            
            let alertController = UIAlertController(title: dateText, message: detailText, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                let storyboard: UIStoryboard = self.storyboard!
                
                
            })
            
            //        // キャンセルボタンを追加
            //        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            //            self.dismiss(animated: true, completion: nil)
            //        }
            //        alertController.addAction(cancel)
            //
            present(alertController, animated: true)
        }
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
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    // アイテム追加ボタン押下時の処理(画面遷移)
    @IBAction func addItem() {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "NewItem") as! NextViewItemController
        nextVC.date = self.date
        
        
        // テーブルビューをリロードする
        self.tableview.reloadData()
        self.present(nextVC, animated: true, completion: nil)
    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
//        let df = DateFormatter()
//        df.dateFormat = "yyyy/MM/dd"
//        let dateString = df.string(from: date)
//        let eventsCount = realm.objects(item.self).filter("date == %@", dateString).count
//
//        switch eventsCount {
//        case 0:
//            return UIColor.gray // イベントがない場合の背景色
//        case 1...2:
//            return UIColor.yellow // 1つまたは2つのイベントの場合の背景色
//        default:
//            return UIColor.red // 3つ以上のイベントの場合の背景色
//        }
//    }
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
func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        let dateString = df.string(from: date)
    print("Date")
        // realmをオプショナルバインディングでアクセス
        if let realm = try? Realm() {
            let eventsCount = realm.objects(item.self).filter("date == %@", dateString).count
        
            switch eventsCount {
            case 0:
                return UIColor.gray // イベントがない場合の背景色
            case 1...2:
                return UIColor.yellow // 1つまたは2つのイベントの場合の背景色
            default:
                return UIColor.red // 3つ以上のイベントの場合の背景色
            }
        }
        return nil
    }
