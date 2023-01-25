//
//  CarritoTableViewCell.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 25/01/23.
//

import UIKit
import SwipeCellKit

class CarritoTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NombreView: UILabel!
    @IBOutlet weak var DepartamentoView: UILabel!
    @IBOutlet weak var PrecioView: UILabel!
    @IBOutlet weak var CantidadView: UILabel!
    @IBOutlet weak var SubtotalView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
