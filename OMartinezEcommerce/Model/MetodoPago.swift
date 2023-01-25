//
//  MetodoPago.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 25/01/23.
//

import Foundation

struct MetodoPago {
    var IdMetodoPago : Int
    var Metodo : String
    
    init(IdMetodoPago: Int, Metodo: String) {
        self.IdMetodoPago = IdMetodoPago
        self.Metodo = Metodo
    }
    
    init(){
        self.IdMetodoPago = 0
        self.Metodo = ""
    }
}
