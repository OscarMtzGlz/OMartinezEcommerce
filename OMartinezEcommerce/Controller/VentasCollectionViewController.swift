//
//  VentasCollectionViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 12/01/23.
//

import UIKit

class VentasCollectionViewController: UICollectionViewController{

    let productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    var NombreProducto : String = ""
    var idDepartamento : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(UINib(nibName:"VentasCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ProductoCard")
        //collectionView.register(UINib(nibName: "VentasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductoCard")
        //loadData()
        validar()

        // Do any additional setup after loading the view.
    }
    //override func viewWillAppear(_ animated: Bool) {
      //  loadData()
    //}
    
    func loadData(){
        let result = productoViewModel.GetAll()
        if result.Correct {
            productos = result.Objects! as! [Producto]
            self.collectionView.reloadData()
        }else{
            //alert
        }
    }
    
    func validar(){
        if self.NombreProducto == ""{
            loadData()
        }else{
            let result = productoViewModel.GetByNombre(NombreProducto: self.NombreProducto)
            if result.Correct {
                productos = result.Objects! as! [Producto]
                self.collectionView.reloadData()
            }
        }
        if self.idDepartamento != 0{
            let result = productoViewModel.GetByIdDepartamento(idDepartamento: self.idDepartamento)
            if result.Correct {
                productos = result.Objects! as! [Producto]
                self.collectionView.reloadData()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCard", for: indexPath) as! VentasCollectionViewCell
    
        // Configure the cell
        cell.NombreView.text = productos[indexPath.row].Nombre
        cell.CampoView.text = String(productos[indexPath.row].PrecioUnitario)
        cell.CampoOp.text = productos[indexPath.row].Descripcion
        
        if productos[indexPath.row].Imagen == "" {
            cell.ImageView.image = UIImage(systemName: "photo.artframe")
        }else{
            let imageData = Data(base64Encoded: productos[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.ImageView.image = UIImage(data: imageData!)
        }
        cell.ImageView.layer.cornerRadius = 20
        cell.container.layer.cornerRadius = 20
        
        //cell.ButtonAdd
        cell.ButtonAdd.tag = indexPath.row
        cell.ButtonAdd.addTarget(self, action: #selector(self.funcAdd), for: .touchUpInside)
        
        return cell
    }
    
    @objc func funcAdd(sender : UIButton){
        print(sender.tag)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
