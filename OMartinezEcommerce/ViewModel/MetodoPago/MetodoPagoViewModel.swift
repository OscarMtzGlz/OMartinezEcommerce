//
//  MetodoPagoViewModel.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 25/01/23.
//

import Foundation
import SQLite3

class MetodoPagoViewModel{
    func GetAll() -> Result {
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdMetodoPago, Metodo FROM MetodoPago"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var metodopago = MetodoPago()
                    
                    metodopago.IdMetodoPago = Int(sqlite3_column_int(statement, 0))
                    metodopago.Metodo = String(cString: sqlite3_column_text(statement, 1))
                    
                    result.Objects?.append(metodopago)
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
