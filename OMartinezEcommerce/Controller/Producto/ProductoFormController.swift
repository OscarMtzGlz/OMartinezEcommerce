//
//  ViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 27/12/22.
//

import UIKit

class ProductoFormController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ActionBtn: UIButton!
    @IBOutlet weak var NombreField: UITextField!
    @IBOutlet weak var PrecioUnitarioField: UITextField!
    @IBOutlet weak var StockField: UITextField!
    @IBOutlet weak var IdProveedorField: UITextField!
    @IBOutlet weak var IdDepartamentoField: UITextField!
    @IBOutlet weak var DescripcionField: UITextField!
    
    let productoViewModel = ProductoViewModel()
    var productoModel : Producto? = nil
    var idProducto : Int = 0
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.isEditing = false
        //let result = productoViewModel.GetAll()
        validar()
        // Do any additional setup after loading the view.
    }
    
    func validar(){
        if idProducto == 0{
            ActionBtn.setTitle("Agregar", for: UIControl.State.normal)
            NombreField.text = ""
            PrecioUnitarioField.text = ""
            StockField.text = ""
            IdProveedorField.text = ""
            IdDepartamentoField.text = ""
            DescripcionField.text = ""
            imageView.image = UIImage(named: "User")
        }else{
            ActionBtn.setTitle("Modificar", for: UIControl.State.normal)
            let result = productoViewModel.GetById(idProducto: self.idProducto)
            if result.Correct {
                var producto = result.Object! as! Producto
                
                NombreField.text = producto.Nombre
                PrecioUnitarioField.text = String(producto.PrecioUnitario)
                StockField.text = String(producto.Stock)
                IdProveedorField.text = String(producto.Proveedor.IdProveedor)
                IdDepartamentoField.text = String(producto.Departamento.IdDepartamento)
                DescripcionField.text = producto.Descripcion
            }
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info [.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageButton(_ sender: UIButton) {
        self.present(imagePicker, animated: true)
    }
    @IBAction func ActionButton(_ sender: UIButton) {
        let alertVacio = UIAlertController(title: "Confirmación", message: "Campo vacio", preferredStyle: .alert)
        let alertIncorrect = UIAlertController(title: "Confirmación", message: "Ocurrio un error", preferredStyle: .alert)
        let alertCorrect = UIAlertController(title: "Confirmación", message: "Ejecucion Correcta", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertVacio.addAction(ok)
        alertCorrect.addAction(ok)
        alertIncorrect.addAction(ok)
        
        guard let nombre = NombreField.text else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let precioUnitario = Double(PrecioUnitarioField.text!) else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let stock = Int(StockField.text!) else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let idProveedor = Int(IdProveedorField.text!) else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let idDepartamento = Int(IdDepartamentoField.text!) else{
            self.present(alertVacio, animated: false)
            return
        }
        let descripcion = DescripcionField.text!
        guard let image = imageView.image else{
            self.present(alertVacio, animated: false)
            return
        }
        let imageString : String
        if imageView.restorationIdentifier == "User" {
            imageString = ""
        }else{
            let imageData = image.pngData()! as NSData
            imageString = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        
        var proveedor = Proveedor()
        proveedor.IdProveedor = idProveedor
        var departamento = Departamento()
        departamento.IdDepartamento = idDepartamento
        
        productoModel = Producto(IdProducto: self.idProducto, Nombre: nombre, PrecioUnitario: precioUnitario, Stock: stock, Proveedor: proveedor , Departamento: departamento, Descripcion: descripcion, Imagen: imageString)
        
        if ActionBtn.currentTitle == "Agregar"{
            
            let result = productoViewModel.Add(producto: productoModel!)
            
            if result.Correct {
                self.present(alertCorrect, animated: false)
            }
        }
        else if ActionBtn.currentTitle == "Modificar"{
            let result = productoViewModel.Update(producto: productoModel!)
            if result.Correct{
                self.present(alertCorrect, animated: false)
            }
        }else{
            self.present(alertIncorrect, animated: false)
        }
    }
    
   // @IBAction func UpdateButton(_ sender: UIButton){
     //   let alertIncorrect = UIAlertController(title: "Confirmación", message: "Campo vacion", preferredStyle: .alert)
     //   let alertCorrect = UIAlertController(title: "Confirmación", message: "Ejecucion Correcta", preferredStyle: .alert)
    //    let ok = UIAlertAction(title: "OK", style: .default)
    //    alertIncorrect.addAction(ok)
    //    alertCorrect.addAction(ok)
        
    //    guard let idProducto = Int(ProductoField.text!) else{
     //       self.present(alertIncorrect, animated: false)
     //       return
     //   }
     //   guard let nombre = NombreField.text else{
     //       self.present(alertIncorrect, animated: false)
     //       return
     //   }
     //   guard let precioUnitario = Double(PrecioUnitarioField.text!) else{
     //       self.present(alertIncorrect, animated: false)
     //       return
     //   }
      //  guard let stock = Int(StockField.text!) else{
      //      self.present(alertIncorrect, animated: false)
     //       return
     //   }
      //  guard let idProveedor = Int(IdProveedorField.text!) else{
     //       self.present(alertIncorrect, animated: false)
      //      return
     //   }
      //  guard let idDepartamento = Int(IdDepartamentoField.text!) else{
      //      self.present(alertIncorrect, animated: false)
      //      return
      //  }
     //   let descripcion = DescripcionField.text!
        
      //  var proveedor = Proveedor()
      //  proveedor.IdProveedor = idProveedor
      //  var departamento = Departamento()
       // departamento.IdDepartamento = idDepartamento
        
      //  productoModel = Producto(IdProducto: idProducto, Nombre: nombre, PrecioUnitario: precioUnitario, Stock: stock, Proveedor: proveedor , Departamento: departamento, Descripcion: descripcion)
      //  let result = productoViewModel.Update(producto: productoModel!)
        
      //  if result.Correct {
      //      self.present(alertCorrect, animated: false)
      //  }
   // }
    
   // @IBAction func DeleteButton(_ sender: UIButton){
   //     let alertIncorrect = UIAlertController(title: "Confirmación", message: "Campo vacion", //preferredStyle: .alert)
     //   let alertCorrect = UIAlertController(title: "Confirmación", message: "Ejecucion Correcta", preferredStyle: .alert)
       // let ok = UIAlertAction(title: "OK", style: .default)
      //  alertIncorrect.addAction(ok)
      //  alertCorrect.addAction(ok)
        
      //  guard let idProducto = Int(ProductoField.text!) else{
      //      self.present(alertIncorrect, animated: false)
      //      return
     //   }
        
      //  let result = productoViewModel.Delete(idProducto: idProducto)
        
      //  if result.Correct {
      //      self.present(alertCorrect, animated: false)
      //  }
   // }
    
}

