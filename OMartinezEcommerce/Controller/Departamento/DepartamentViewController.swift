//
//  DepartamentViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 04/01/23.
//

import UIKit

class DepartamentViewController: UIViewController {

    @IBOutlet weak var ActionBtn: UIButton!
    
    @IBOutlet weak var Nombrefield: UITextField!
    @IBOutlet weak var Areafield: UITextField!
    
    let departamentoViewModel = DepartamentoViewModel()
    var departamentoModel : Departamento? = nil
    var idDepartamento : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        validar()
    }
    
    func validar(){
        if idDepartamento == 0 {
            ActionBtn.setTitle("Agregar", for: UIControl.State.normal)
            Nombrefield.text = ""
            Areafield.text = ""
        }else{
            ActionBtn.setTitle("Modificar", for: UIControl.State.normal)
            let result = departamentoViewModel.GetById(idDepartamento: self.idDepartamento)
            if result.Correct {
                var departamento = result.Object! as! Departamento
                
                Nombrefield.text = departamento.Nombre
                Areafield.text = String(departamento.Area.IdArea)
            }
        }
    }
    
    @IBAction func ActionBtn(_ sender: UIButton) {
        let alertVacio = UIAlertController(title: "Confirmación", message: "Campo vacio", preferredStyle: .alert)
        let alertIncorrect = UIAlertController(title: "Confirmación", message: "Ocurrio un error", preferredStyle: .alert)
        let alertCorrect = UIAlertController(title: "Confirmación", message: "Ejecución correcta", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alertVacio.addAction(ok)
        alertIncorrect.addAction(ok)
        alertCorrect.addAction(ok)
        
        guard let nombre = Nombrefield.text else{
            self.present(alertVacio, animated: false)
            return
        }
        guard let idArea = Int(Areafield.text!) else{
            self.present(alertVacio, animated: false)
            return
        }
        
        var area = Area()
        area.IdArea = idArea
        departamentoModel = Departamento(IdDepartamento: self.idDepartamento, Nombre: nombre, Area: area)
        
        if ActionBtn.currentTitle == "Agregar" {
            let result = departamentoViewModel.Add(departamento: departamentoModel!)
            
            if result.Correct {
                self.present(alertCorrect, animated: false)
            }
        }else if ActionBtn.currentTitle == "Modificar" {
            let result = departamentoViewModel.Update(departamento: departamentoModel!)
            
            if result.Correct {
                self.present(alertCorrect, animated: false)
            }
        }else{
            self.present(alertIncorrect, animated: false)
        }
    }
}
