//
//  VentasCollectionViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 12/01/23.
//

import UIKit

class VentasCollectionViewController: UICollectionViewController{

    let productoViewModel = ProductoViewModel()
    let ventaViewModel = VentaViewModel()
    var productos = [Producto]()
    var NombreProducto : String = ""
    var idDepartamento : Int = 0
    var idProducto : Int = 0
    
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.collectionView.addGestureRecognizer(tap)
        self.collectionView.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)){
            self.idProducto = productos[indexPath.row].IdProducto
            self.performSegue(withIdentifier: "DetalleSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleSegue" {
            let detalleView = segue.destination as! DetalleViewController
            detalleView.IdProducto = self.idProducto
        }
    }
    //override func viewWillAppear(_ animated: Bool) {
      //  loadData()
    //}
    
    func loadData(){
        let alert = UIAlertController(title: "Error", message: "Ocurrio un error", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        let result = productoViewModel.GetAll()
        if result.Correct {
            productos = result.Objects! as! [Producto]
            self.collectionView.reloadData()
        }else{
            self.present(alert, animated: false)
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

    
    @IBAction func CarAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "CarritoSegue", sender: self)
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
        
        cell.ButtonAdd.tag = indexPath.row
        cell.ButtonAdd.addTarget(self, action: #selector(self.funcAdd), for: .touchUpInside)
        
        return cell
    }
    
    @objc func funcAdd(sender : UIButton){
        //print(sender.tag)
        //print(productos[sender.tag].IdProducto)
        
        var result = ventaViewModel.GetByIdProducto(idProducto: productos[sender.tag].IdProducto)
        if result.Correct {
            UpdateCarrito(result: result)
//            var ventaProducto = result.Object! as! VentaProducto
//            var ventaUpdate = VentaProducto()
//            ventaUpdate.IdVentaProducto = ventaProducto.IdVentaProducto
//            ventaUpdate.Cantidad = ventaProducto.Cantidad + 1
//            ventaUpdate.Producto.IdProducto = productos[sender.tag].IdProducto
//            result = ventaViewModel.UpdateCantidad(ventaProducto: ventaUpdate)
//            if result.Correct {
//                print("cantidad añadida")
//                self.performSegue(withIdentifier: "CarritoSegue", sender: self)
//            }
        }else{
            AddCarrito(IdProducto: productos[sender.tag].IdProducto)
//            var producto = Producto()
//            producto.IdProducto = productos[sender.tag].IdProducto
//            var ventaProducto = VentaProducto(IdVentaProducto: 0, Cantidad: 1, Producto: producto, Total: 0.0)
//            result = ventaViewModel.Add(ventaProducto: ventaProducto)
//            if result.Correct {
//                print("añadido")
//                self.performSegue(withIdentifier: "CarritoSegue", sender: self)
//            }
        }
    }
    
    func UpdateCarrito(result : Result){
        let alert = UIAlertController(title: "Añadido", message: "Su producto ha sido añadido", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        var ventaProducto = result.Object! as! VentaProducto
        ventaProducto.Cantidad = ventaProducto.Cantidad + 1
        let newresult = ventaViewModel.UpdateCantidad(ventaProducto: ventaProducto)
        if newresult.Correct {
            self.present(alert, animated: false)
        }
    }
    
    func AddCarrito(IdProducto : Int){
        let alert = UIAlertController(title: "Añadido", message: "Su producto ha sido añadido", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        var producto = Producto()
        producto.IdProducto = IdProducto
        let ventaProducto = VentaProducto(IdVentaProducto: 0, Cantidad: 1, Producto: producto, Total: 0.0)
        let result = ventaViewModel.Add(ventaProducto: ventaProducto)
        if result.Correct {
            self.present(alert, animated: false)
        }
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
