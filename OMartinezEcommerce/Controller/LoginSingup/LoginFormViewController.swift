//
//  LoginFormViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 11/01/23.
//@

import UIKit
import FirebaseAuth

class LoginFormViewController: UIViewController {

    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var ViewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ViewContainer.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginAction(_ sender: UIButton) {
        let alertVacio = UIAlertController(title: "Alerta", message: "Campo vacio", preferredStyle: .alert)
        let alertCorrect = UIAlertController(title: "Confirmación", message: "Usuario creado", preferredStyle: .alert)
        let alertIncorrect = UIAlertController(title: "Error", message: "El usuario no pudo ser registrado", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default)
        
        alertVacio.addAction(OK)
        alertCorrect.addAction(OK)
        alertIncorrect.addAction(OK)
        
        guard let email = EmailField.text, EmailField.text != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let pass = PasswordField.text, PasswordField.text != "" else{
            self.present(alertVacio, animated: false)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if let error = error {
                self.present(alertIncorrect, animated: false)
            }else{
                self.performSegue(withIdentifier: "loginSegue", sender: self)
                self.present(alertCorrect, animated: false)
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
