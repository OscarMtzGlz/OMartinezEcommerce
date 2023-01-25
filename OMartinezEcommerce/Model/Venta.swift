//
//  Venta.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 25/01/23.
//

import Foundation

struct Venta{
    var IdVenta : Int
    var IdUsuario : Int
    var Total : Double
    var Fecha : Date
    var MetodoPago : MetodoPago
    
    init(IdVenta: Int, IdUsuario: Int, Total: Double, Fecha: Date, MetodoPago: MetodoPago) {
        self.IdVenta = IdVenta
        self.IdUsuario = IdUsuario
        self.Total = Total
        self.Fecha = Fecha
        self.MetodoPago = MetodoPago
    }
    
    init(){
        self.IdVenta = 0
        self.IdUsuario = 0
        self.Total = 0.0
        self.Fecha = Date.now
        self.MetodoPago = OMartinezEcommerce.MetodoPago()
    }
}
