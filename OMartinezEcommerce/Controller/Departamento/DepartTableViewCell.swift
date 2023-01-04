//
//  DepartTableViewCell.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 04/01/23.
//

import UIKit
import SwipeCellKit

class DepartTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var Nombrelbl: UILabel!
    @IBOutlet weak var Arealbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
