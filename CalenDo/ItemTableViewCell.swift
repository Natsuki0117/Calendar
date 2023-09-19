//
//  ItemTableViewCell.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/07/19.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet var titlelabel: UILabel!
    @IBOutlet var datelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(title: String, date: String) {
        titlelabel.text = title
        
        datelabel.text = date
        
    }
}
