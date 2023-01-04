//
//  Departamento.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 28/12/22.
//

import Foundation

struct Departamento {
    var IdDepartamento : Int
    var Nombre : String
    var Area : Area
    
    init(IdDepartamento: Int, Nombre: String, Area: Area) {
        self.IdDepartamento = IdDepartamento
        self.Nombre = Nombre
        self.Area = Area
    }
    
    init(){
        self.IdDepartamento = 0
        self.Nombre = ""
        self.Area = OMartinezEcommerce.Area()
    }
}
