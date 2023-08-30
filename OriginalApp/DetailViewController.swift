//
//  DetailViewController.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/08/30.
//

import UIKit

class DetailViewController: UIViewController {
    
   @IBOutlet  var todo: String!
   @IBOutlet var detail: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.todo = "aaa"
        
    }
    
    @IBAction func back() {
        self.dismiss(animated: true)
    }

}
