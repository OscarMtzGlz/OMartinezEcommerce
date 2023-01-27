//
//  ProductoTableViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 29/12/22.
//

import UIKit
import SwipeCellKit

class GetAllTableViewController: UITableViewController {

    let productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    var idProducto : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ProductoCell")
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
        let alert = UIAlertController(title: "Error", message: "Ocurrio un error", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        let result = productoViewModel.GetAll()
        if result.Correct {
            productos = result.Objects! as! [Producto]
            tableView.reloadData()
        }else{
            self.present(alert, animated: false)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoTableViewCell
        
        cell.delegate = self
        
        cell.viewContainer.layer.cornerRadius = 20
        cell.Nombrelbl.text = productos[indexPath.row].Nombre
        cell.PrecioUnitariolbl.text = "$"+String(productos[indexPath.row].PrecioUnitario)
        cell.Stocklbl.text = "Stock:"+String(productos[indexPath.row].Stock)
        cell.Descripcionlbl.text = productos[indexPath.row].Descripcion
        cell.Proveedorlbl.text = productos[indexPath.row].Proveedor.Nombre
        cell.Departamentolbl.text = productos[indexPath.row].Departamento.Nombre
        
        if productos[indexPath.row].Imagen == "" {
            cell.ImageUser.image = UIImage(systemName: "photo.artframe")
        }else{
            let imageData = Data(base64Encoded: productos[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.ImageUser.image = UIImage(data: imageData!)
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

extension GetAllTableViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        //Delete
        if orientation == .right{
            guard orientation == .right else {return nil}
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                self.idProducto = self.productos[indexPath.row].IdProducto
                
                let result = self.productoViewModel.Delete(idProducto: self.idProducto)
                
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
                self.idProducto = self.productos[indexPath.row].IdProducto
                self.performSegue(withIdentifier: "Updatesegues", sender: self)
                self.loadData()
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
            let productoForm = segue.destination as! ProductoFormController
            productoForm.idProducto = self.idProducto
        }
    }
}
