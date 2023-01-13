//
//  AreaViewController.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 12/01/23.
//

import UIKit

class AreaViewController: UIViewController {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    
    let areaViewModel = AreaViewModel()
    var areas = [Area]()
    var idArea : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: "VentasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductoCard")
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        let result = areaViewModel.GetAll()
        if result.Correct {
            areas = result.Objects! as! [Area]
            self.collectionView.reloadData()
        }else{
            //alert
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
extension AreaViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCard", for: indexPath) as! VentasCollectionViewCell
        
        cell.NombreView.text = areas[indexPath.row].Nombre
        cell.CampoView.text = ""
        cell.ImageView.image = UIImage(systemName: "photo.artframe")
        cell.ImageView.layer.cornerRadius = 20
        cell.container.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.idArea = self.areas[indexPath.row].IdArea
        self.performSegue(withIdentifier: "DepartamentoSegues", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        if segue.identifier == "DepartamentoSegues" {
//            let departamentoCollection = segue.destination as! DepartamentoCollectionViewController
//            departamentoCollection.idArea = self.idArea
//        }
//    }
}
