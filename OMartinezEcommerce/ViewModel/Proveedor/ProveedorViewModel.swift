//
//  ProveedorViewModel.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 10/01/23.
//

import Foundation
import SQLite3

class ProveedorViewModel {
    func GetAll() -> Result {
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdProveedor, Nombre FROM Proveedor"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var proveedor = Proveedor()
                    
                    proveedor.IdProveedor = Int(sqlite3_column_int(statement, 0))
                    proveedor.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    
                    result.Objects?.append(proveedor)
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
}
