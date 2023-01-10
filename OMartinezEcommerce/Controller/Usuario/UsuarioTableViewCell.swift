//
//  UsuarioTableViewCell.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 06/01/23.
//

import UIKit
import SwipeCellKit

class UsuarioTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NombreView: UILabel!
    @IBOutlet weak var ApellidoPaternoView: UILabel!
    @IBOutlet weak var ApellidoMaternoView: UILabel!
    @IBOutlet weak var UserNameView: UILabel!
    @IBOutlet weak var EmailView: UILabel!
    @IBOutlet weak var PasswordView: UILabel!
    @IBOutlet weak var FechaNacimientoView: UILabel!
    @IBOutlet weak var SexoView: UILabel!
    @IBOutlet weak var Rol: UILabel!
    @IBOutlet weak var CURPView: UILabel!
    @IBOutlet weak var CelularView: UILabel!
    @IBOutlet weak var TelefonoView: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
