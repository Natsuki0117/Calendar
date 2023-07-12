//
//  TableViewCell.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/07/12.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var titlelabel: UILabel!
    @IBOutlet var todolabel: UILabel!
    @IBOutlet var markimageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, date: String, isMarked: Bool) {
        titlelabel.text  = title
        
        if isMarked {
            markimageview.image = UIImage(systemName:"star.fill")
            
        }else {
            markimageview.image = UIImage(systemName: "star")
            
        }
        
    }
}
