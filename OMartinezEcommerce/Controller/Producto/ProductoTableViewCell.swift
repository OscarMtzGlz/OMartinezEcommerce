//
//  TableViewCell.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 29/12/22.
//

import UIKit
import SwipeCellKit

class ProductoTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var ImageUser: UIImageView!
    @IBOutlet weak var Descripcionlbl: UILabel!
    @IBOutlet weak var Stocklbl: UILabel!
    @IBOutlet weak var PrecioUnitariolbl: UILabel!
    @IBOutlet weak var Nombrelbl: UILabel!
    @IBOutlet weak var Departamentolbl: UILabel!
    @IBOutlet weak var Proveedorlbl: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
