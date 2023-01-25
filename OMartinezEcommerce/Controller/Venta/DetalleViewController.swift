//
//  DetalleViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 23/01/23.
//

import UIKit

class DetalleViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ButtonAdd: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var Nombrelbl: UILabel!
    @IBOutlet weak var Preciolbl: UILabel!
    @IBOutlet weak var stocklbl: UILabel!
    @IBOutlet weak var Arealbl: UILabel!
    @IBOutlet weak var Departamentolbl: UILabel!
    @IBOutlet weak var Descripcionlbl: UILabel!
    @IBOutlet weak var Cantidadtxt: UITextField!
    
    var IdProducto : Int = 0
    let productoViewModel = ProductoViewModel()
    var producto = Producto()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.delegate = self
//        tableView.dataSource = self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        let result = productoViewModel.GetById(idProducto: self.IdProducto)
        if result.Correct {
            producto = result.Object! as! Producto

            Nombrelbl.text = producto.Nombre
            Preciolbl.text = "Precio: $\(producto.PrecioUnitario)"
            stocklbl.text = "Unidades: \(producto.Stock)"
            Arealbl.text = "Area: \(producto.Departamento.Area.Nombre)"
            Departamentolbl.text = "Departamento: \(producto.Departamento.Nombre)"
            Descripcionlbl.text = producto.Descripcion
            if producto.Imagen == "" {
                ImageView.image = UIImage(systemName: "photo.artframe")
            }else{
                let imageData = Data(base64Encoded: producto.Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                ImageView.image = UIImage(data: imageData!)
            }
            Cantidadtxt.text = "1"
        }
    }
    
    @IBAction func CompraAction(_ sender: UIButton) {
        let ventaViewModel = VentaViewModel()
        let cant = Cantidadtxt.text!
        var result = ventaViewModel.GetByIdProducto(idProducto: producto.IdProducto)
        if result.Correct {
            var ventaProducto = result.Object! as! VentaProducto
            var ventaUpdate = VentaProducto()
            ventaUpdate.IdVentaProducto = ventaProducto.IdVentaProducto
            ventaUpdate.Cantidad = (Int(cant) ?? 0) + 1
            ventaUpdate.Producto.IdProducto = producto.IdProducto
            result = ventaViewModel.UpdateCantidad(ventaProducto: ventaUpdate)
            if result.Correct {
                self.dismiss(animated: true)
            }
        }else{
            var ventaProducto = VentaProducto(IdVentaProducto: 0, Cantidad: Int(cant) ?? 1, Producto: producto, Total: 0.0)
            result = ventaViewModel.Add(ventaProducto: ventaProducto)
            if result.Correct {
                self.dismiss(animated: true)
            }
        }
    }
}
