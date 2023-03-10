//
//  CarritoViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 24/01/23.
//

import UIKit
import SwipeCellKit

class CarritoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TotalView: UILabel!
    
    
    let ventaViewModel = VentaViewModel()
    var ventaproductos = [VentaProducto]()
    var IdVentaProducto : Int = 0
    var TotalVenta : Double = 0.0
    
    var defaultOptions = SwipeOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CarritoTableViewCell", bundle: nil), forCellReuseIdentifier: "CarritoCell")

        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
        TotalView.text = "Total: $\(TotalVenta)"
    }
    
    func loadData(){
        let alert = UIAlertController(title: "Error", message: "Ocurrio un erro", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        let result = ventaViewModel.GetAll()
        if result.Correct {
            ventaproductos = result.Objects! as! [VentaProducto]
            //TotalView.text = "Total: $\(TotalVenta)"
            TotalVenta = 0.0
            tableView.reloadData()
        }else{
            self.present(alert, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        TotalView.text = "Total: 0.0"
    }
    
    @IBAction func FinalizarAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FinalizarSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FinalizarSegue"{
            let finalizarView = segue.destination as! FinalizarViewController
            finalizarView.total = self.TotalVenta
            finalizarView.cantidadProductos = self.ventaproductos.count
        }
    }
}
extension CarritoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ventaproductos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoTableViewCell
        
        let cantidad = Double(ventaproductos[indexPath.row].Cantidad)
        let precio = ventaproductos[indexPath.row].Producto.PrecioUnitario

        let subtotal = cantidad * precio
        self.TotalVenta = TotalVenta + ventaproductos[indexPath.row].Total
        TotalView.text = "Total: $\(TotalVenta)"
        cell.delegate = self
        
        cell.viewContainer.layer.cornerRadius = 20
        cell.NombreView.text = ventaproductos[indexPath.row].Producto.Nombre
        cell.DepartamentoView.text = ventaproductos[indexPath.row].Producto.Departamento.Nombre
        cell.PrecioView.text = "$"+String(ventaproductos[indexPath.row].Producto.PrecioUnitario)
        cell.CantidadView.text = "Cantidad: "+String(ventaproductos[indexPath.row].Cantidad)
        cell.SubtotalView.text = "SubTotal: $\(subtotal)"
        
        if ventaproductos[indexPath.row].Producto.Imagen == "" {
            cell.ImageView.image = UIImage(systemName: "photo.artframe")
        }else{
            let imageData = Data(base64Encoded: ventaproductos[indexPath.row].Producto.Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.ImageView.image = UIImage(data: imageData!)
        }
        
        return cell
    }
}
extension CarritoViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let alertCorrect = UIAlertController(title: "Eliminado", message: "Producto eliminado del carrito", preferredStyle: .alert)
        let alertIncorrect = UIAlertController(title: "No Eliminado", message: "El producto no pudo ser eliminado del carrito", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default){(action) in
            let result = self.ventaViewModel.GetAll()
            if result.Correct {
                self.ventaproductos = result.Objects! as! [VentaProducto]
                self.TotalView.text = "Totoal: $\(self.ventaproductos[indexPath.row].Total)"
            }
        }
        alertCorrect.addAction(ok)
        alertIncorrect.addAction(ok)
        
        guard orientation == .right else {return nil}
        let deleteAction = SwipeAction(style: .destructive, title: "Eliminar") { action, indexPath in
            self.IdVentaProducto = self.ventaproductos[indexPath.row].IdVentaProducto
            
            let result = self.ventaViewModel.GetByIdVenta(idVenta: self.IdVentaProducto)
            if result.Correct {
                var ventaProducto = result.Object! as! VentaProducto
                if ventaProducto.Cantidad > 1 {
                    ventaProducto.Cantidad = ventaProducto.Cantidad - 1
                    let resultUpdate = self.ventaViewModel.UpdateCantidad(ventaProducto: ventaProducto)
                    if resultUpdate.Correct {
                        self.present(alertCorrect, animated: false)
                    }else{
                        self.present(alertIncorrect, animated: false)
                    }
                }else{
                    let resultDelete = self.ventaViewModel.Delete(idVentaProducto: self.IdVentaProducto)
                    if resultDelete.Correct {
                        //self.TotalVenta = self.ventaproductos[indexPath.row].Total
                        self.present(alertCorrect, animated: false)
                    }else{
                        self.present(alertIncorrect, animated: false)
                    }
                }
            }
            
            self.loadData()
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions{
        
        var options = SwipeOptions()
        options.expansionStyle = orientation == .right ? .selection: .destructive
        options.transitionStyle = defaultOptions.transitionStyle
        
        return options
    }
}
