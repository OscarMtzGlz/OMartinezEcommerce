//
//  UsuarioViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 06/01/23.
//

import UIKit

class UsuarioViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NombreField: UITextField!
    @IBOutlet weak var ApellidoPaternoField: UITextField!
    @IBOutlet weak var ApellidoMaternoField: UITextField!
    @IBOutlet weak var UserNameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var SexoField: UITextField!
    @IBOutlet weak var DataPickerField: UIDatePicker!
    @IBOutlet weak var CURPField: UITextField!
    @IBOutlet weak var CelularField: UITextField!
    @IBOutlet weak var TelefonoField: UITextField!
    @IBOutlet weak var ActionBtn: UIButton!
    
    let usuarioViewModel = UsuarioViewModel()
    var usuarioModel : UsuarioC? = nil
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.isEditing = false
        
        ActionBtn.setTitle("Agregar", for: .normal)
        
        usuarioViewModel.GetAll()
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ImageView.image = info [.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ImageBtn(_ sender: UIButton) {
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func ActionButton(_ sender: UIButton) {
        let alertVacio = UIAlertController(title: "Alerta", message: "Campo vacio", preferredStyle: .alert)
        let alertCorrect = UIAlertController(title: "Confirmación", message: "Ejecución correcta", preferredStyle: .alert)
        let alertIncorrect = UIAlertController(title: "Error", message: "Ocurrio un error", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default)
        
        alertVacio.addAction(OK)
        alertCorrect.addAction(OK)
        alertIncorrect.addAction(OK)
        
        guard let nombre = NombreField.text, nombre != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let apellidoPaterno = ApellidoPaternoField.text, apellidoPaterno != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let apellidoMaterno = ApellidoMaternoField.text, apellidoMaterno != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let userName = UserNameField.text, userName != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let email = EmailField.text, email != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let password = PasswordField.text, password != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let fechaNacimiento = DataPickerField else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let sexo = SexoField.text, sexo != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let curp = CURPField.text, curp != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let celular = CelularField.text, celular != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let telefono = TelefonoField.text, telefono != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let imagen = ImageView.image else{
            self.present(alertVacio, animated: false)
            return
        }
        
        let imageString : String
        if ImageView.restorationIdentifier == "User"{
            imageString = ""
        }else{
            let imageData = imagen.pngData()! as NSData
            imageString = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        
        usuarioModel = UsuarioC(IdUsuario: 0, UserName: userName, Nombre: nombre, ApellidoPaterno: apellidoPaterno, ApellidoMaterno: apellidoMaterno, Email: email, Password: password, FechaNacimiento: fechaNacimiento.date, Sexo: sexo, Telefono: telefono, Celular: celular, CURP: curp, Imagen: imageString)
        
        if ActionBtn.currentTitle == "Agregar" {
            let result = usuarioViewModel.Add(usuario: usuarioModel!)
            if result.Correct {
                self.present(alertCorrect, animated: false)
            }
        }else if ActionBtn.currentTitle == "Modificar" {
            
        }else{
            self.present(alertIncorrect, animated: false)
        }
    }
}