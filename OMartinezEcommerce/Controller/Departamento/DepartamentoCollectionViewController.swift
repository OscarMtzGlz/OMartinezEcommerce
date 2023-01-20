//
//  DepartamentoCollectionViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 13/01/23.
//

import UIKit

class DepartamentoCollectionViewController: UICollectionViewController {
    
    let departamentoViewModel = DepartamentoViewModel()
    var departamentos = [Departamento]()
    var idArea : Int = 0
    var idDepartamento : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(UINib(nibName: "VentasCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ProductoCard")
        loadData()

        
        let tap = UITapGestureRecognizer(target: self,action:#selector(self.handleTap(_:)))
        self.collectionView.addGestureRecognizer(tap)
        self.collectionView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)){
            self.idDepartamento = self.departamentos[indexPath.row].IdDepartamento
            self.performSegue(withIdentifier: "ProductosSegues", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        let result = departamentoViewModel.GetByIdArea(self.idArea)
        if result.Correct {
            departamentos = result.Objects! as! [Departamento]
            self.collectionView.reloadData()
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
        return departamentos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCard", for: indexPath) as! VentasCollectionViewCell
    
        // Configure the cell
        cell.NombreView.text = departamentos[indexPath.row].Nombre
        cell.CampoView.text = ""
        cell.CampoOp.text = ""
        cell.ImageView.image = UIImage(systemName: "photo.artframe")
        cell.ImageView.layer.cornerRadius = 20
        cell.container.layer.cornerRadius = 20
        cell.ButtonAdd.isHidden = true
    
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.idDepartamento = departamentos[indexPath.row].IdDepartamento
//        self.performSegue(withIdentifier: "ProductosSegues", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductosSegues" {
            let productoCollection = segue.destination as! VentasCollectionViewController
            productoCollection.idDepartamento = self.idDepartamento
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
