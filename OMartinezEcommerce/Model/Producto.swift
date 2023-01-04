//
//  Producto.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 28/12/22.
//

import Foundation

struct Producto {
    var IdProducto : Int
    var Nombre : String
    var PrecioUnitario : Double
    var Stock : Int
    var Proveedor : Proveedor
    var Departamento : Departamento
    var Descripcion : String
    
    init(IdProducto: Int, Nombre: String, PrecioUnitario: Double, Stock: Int, Proveedor: Proveedor, Departamento: Departamento, Descripcion: String) {
        self.IdProducto = IdProducto
        self.Nombre = Nombre
        self.PrecioUnitario = PrecioUnitario
        self.Stock = Stock
        self.Proveedor = Proveedor
        self.Departamento = Departamento
        self.Descripcion = Descripcion
    }
    
    init(){
        self.IdProducto = 0
        self.Nombre = ""
        self.PrecioUnitario = 0.0
        self.Stock = 0
        self.Proveedor = OMartinezEcommerce.Proveedor()
        self.Departamento = OMartinezEcommerce.Departamento()
        self.Descripcion = ""
    }
    //var Imagen : VARBINARY
}
