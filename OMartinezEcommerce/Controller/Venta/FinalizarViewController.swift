//
//  FinalizarViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 25/01/23.
//

import UIKit
import iOSDropDown

class FinalizarViewController: UIViewController {

    @IBOutlet weak var Totallabel: UILabel!
    @IBOutlet weak var MetodoPagoDropDown: DropDown!
    @IBOutlet weak var CantidadProductoslabel: UILabel!
    
    var total : Double = 0.0
    var cantidadProductos : Int = 0
    let metodopagoViewModel = MetodoPagoViewModel()
    var IdMetodoPago : Int = 0
    let ventaViewModel = VentaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Totallabel.text = "Totol: $"+String(total)
        CantidadProductoslabel.text = "Numero de Productos:"+String(cantidadProductos)
        
        MetodoPagoDropDown.optionArray = [String]()
        MetodoPagoDropDown.optionIds = [Int]()
        
        loadData()
        
        MetodoPagoDropDown.didSelect{ selectedText, index, id in
            self.IdMetodoPago = id
        }
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        let result = metodopagoViewModel.GetAll()
        if result.Correct {
            for metodopago in result.Objects as! [MetodoPago] {
                MetodoPagoDropDown.optionArray.append(metodopago.Metodo)
                MetodoPagoDropDown.optionIds?.append(metodopago.IdMetodoPago)
            }
        }
    }
    
    @IBAction func FinalizarAction(_ sender: UIButton) {
        var metodo = MetodoPago()
        metodo.IdMetodoPago = self.IdMetodoPago
        var result = ventaViewModel.AddVenta(venta: Venta(IdVenta: 0, IdUsuario: 1, Total: self.total, Fecha: Date.now, MetodoPago: metodo))
        if result.Correct {
            result = ventaViewModel.DeleteCarrito()
            if result.Correct{
                self.dismiss(animated: true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
