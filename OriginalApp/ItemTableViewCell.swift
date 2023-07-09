//
//  ItemTableViewCell.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/07/10.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet var titlelabel: UILabel!
    @IBOutlet var datelabel: UILabel!
    @IBOutlet var markImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setcell(title: String, date: Int, isMarked: Bool)
    
    {titlelabel.text = title
        
        datelabel.text = String(date)
        
        if isMarked {
            markImageView.image = UIImage(systemname: "star.fill")
            
        }else {
            markImageView.image = UIImage(systemnam: "star")
        }
    }
    
}
