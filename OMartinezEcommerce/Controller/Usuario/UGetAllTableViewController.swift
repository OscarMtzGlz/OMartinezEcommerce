//
//  UGetAllTableViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 06/01/23.
//

import UIKit
import SwipeCellKit

class UGetAllTableViewController: UITableViewController {
    
    let usuarioViewModel = UsuarioViewModel()
    var usuarios = [UsuarioC]()
    var posicionUsuario : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "UsuarioTableViewCell", bundle: nil), forCellReuseIdentifier: "UsuarioCell")
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        let result = usuarioViewModel.GetAll()
        if result.Correct {
            usuarios = result.Objects! as! [UsuarioC]
            tableView.reloadData()
        }else{
            //alert
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioTableViewCell
        var date = usuarios[indexPath.row].FechaNacimiento
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        cell.delegate = self
        
        cell.NombreView.text = usuarios[indexPath.row].Nombre
        cell.ApellidoPaternoView.text = usuarios[indexPath.row].ApellidoPaterno
        cell.ApellidoMaternoView.text = usuarios[indexPath.row].ApellidoMaterno
        cell.UserNameView.text = usuarios[indexPath.row].UserName
        cell.EmailView.text = usuarios[indexPath.row].Email
        cell.PasswordView.text = usuarios[indexPath.row].Password
        cell.FechaNacimientoView.text = dateFormatter.string(from: date)
        cell.SexoView.text = usuarios[indexPath.row].Sexo
        cell.CURPView.text = usuarios[indexPath.row].CURP
        cell.TelefonoView.text = usuarios[indexPath.row].Telefono
        cell.CelularView.text = usuarios[indexPath.row].Celular
        
        if usuarios[indexPath.row].Imagen == "" {
            cell.ImageView.image = UIImage(named: "User")
        }else{
            let imageData = Data(base64Encoded: usuarios[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.ImageView.image = UIImage(data: imageData!)
        }
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UGetAllTableViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        //Delete
        if orientation == .right{
            guard orientation == .right else {return nil}
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                self.posicionUsuario = indexPath.row
                
                let result = self.usuarioViewModel.Delete(posicionUsuario: self.posicionUsuario)
                
                let ok = UIAlertAction(title: "OK", style: .default)
                
                if result.Correct{
                    let alertCorrect = UIAlertController(title: "Confirmación", message: "Ejecucion Correcta", preferredStyle: .alert)
                    alertCorrect.addAction(ok)
                    self.present(alertCorrect, animated: false)
                }else{
                    let alertIncorrect = UIAlertController(title: "Confirmación", message: "Campo vacio", preferredStyle: .alert)
                    alertIncorrect.addAction(ok)
                    self.present(alertIncorrect, animated: false)
                }
                self.loadData()
            }
            // customize the action appearance
            deleteAction.image = UIImage(named: "delete")
            return [deleteAction]
        }
        
        //Update
        if orientation == .left {
            guard orientation == .left else {return nil}
            let updateAction = SwipeAction(style: .destructive, title: "Update"){ action, indexPath in
                if indexPath.row >= 0{
                    self.posicionUsuario = indexPath.row + 1
                }else{
                    self.posicionUsuario = indexPath.row
                }
                self.performSegue(withIdentifier: "Updatesegues", sender: self)
            }
            
            updateAction.image = UIImage(named: "update")
            updateAction.backgroundColor = UIColor.systemBlue
            return [updateAction]
        }
        else{
            return nil
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Updatesegues"{
            let usuarioForm = segue.destination as! UsuarioViewController
            usuarioForm.posicionUsuario = self.posicionUsuario
        }
    }
}
