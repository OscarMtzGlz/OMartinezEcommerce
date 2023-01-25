//
//  VentaProducto.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 24/01/23.
//

import Foundation

struct VentaProducto{
    var IdVentaProducto : Int
    var Cantidad : Int
    var Producto : Producto
    var Total : Double
    
    init(IdVentaProducto: Int, Cantidad: Int, Producto: Producto, Total: Double) {
        self.IdVentaProducto = IdVentaProducto
        self.Cantidad = Cantidad
        self.Producto = Producto
        self.Total = Total
    }
    
    init(){
        self.IdVentaProducto = 0
        self.Cantidad = 0
        self.Producto = OMartinezEcommerce.Producto()
        self.Total = 0.0
    }
}
