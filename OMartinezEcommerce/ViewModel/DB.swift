//
//  DB.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 27/12/22.
//

import Foundation
import SQLite3

class DB{
    let path : String = "OMartinezEcommerce.sql"
    var db : OpaquePointer? = nil
    init(){
        db = OpenConexion()
    }
    func OpenConexion() -> OpaquePointer? {
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(self.path)
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) == SQLITE_OK{
            print("Conexion correcta")
            print(filePath)
            return db
        }else{
            print("Conexion fallida")
            return nil
        }
    }
}
