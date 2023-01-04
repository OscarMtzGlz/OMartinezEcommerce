//
//  ProductoViewModel.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 28/12/22.
//

import Foundation
import SQLite3

class ProductoViewModel {
    let productoModel : Producto? = nil
    
    func Add(producto : Producto) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Producto(Nombre, PrecioUnitario, Stock, IdProveedor, IdDepartamento,Descripcion) VALUES (?,?,?,?,?,?)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, (producto.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, producto.PrecioUnitario)
                sqlite3_bind_int(statement, 3, Int32(producto.Stock))
                sqlite3_bind_int(statement, 4, Int32(producto.Proveedor.IdProveedor))
                sqlite3_bind_int(statement, 5, Int32(producto.Departamento.IdDepartamento))
                sqlite3_bind_text(statement, 6, (producto.Descripcion as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else{
                    result.Correct = false
                }
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
    
    func Update(producto : Producto) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "UPDATE Producto SET Nombre = '\(producto.Nombre)', PrecioUnitario = \(producto.PrecioUnitario), Stock = \(producto.Stock), IdProveedor = \(producto.Proveedor.IdProveedor), IdDepartamento = \(producto.Departamento.IdDepartamento), Descripcion = '\(producto.Descripcion)' WHERE IdProducto = \(producto.IdProducto)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                //sqlite3_bind_text(statement, 1, (producto.Nombre as NSString).utf8String, -1, nil)
                //sqlite3_bind_double(statement, 2, producto.PrecioUnitario)
                //sqlite3_bind_int(statement, 3, Int32(producto.Stock))
                //sqlite3_bind_int(statement, 4, Int32(producto.Proveedor.IdProveedor))
                //sqlite3_bind_int(statement, 5, Int32(producto.Departamento.IdDepartamento))
                //sqlite3_bind_text(statement, 6, (producto.Descripcion as NSString).utf8String, -1, nil)
                //sqlite3_bind_int(statement, 7, Int32(producto.IdProducto))
                print(query)
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else{
                    result.Correct = false
                }
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
    
    func Delete(idProducto : Int) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "DELETE FROM Producto WHERE IdProducto = ?"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_int(statement, 1, Int32(idProducto))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else{
                    result.Correct = false
                }
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
    
    func GetAll() -> Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdProducto,Nombre,PrecioUnitario,Stock,IdProveedor,IdDepartamento,Descripcion FROM Producto"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var producto = Producto()
                    
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement, 2))
                    producto.Stock = Int(sqlite3_column_int(statement, 3))
                    producto.Proveedor = Proveedor()
                    producto.Proveedor.IdProveedor = Int(sqlite3_column_int(statement, 4))
                    producto.Departamento = Departamento()
                    producto.Departamento.IdDepartamento = Int(sqlite3_column_int(statement, 5))
                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 6))
                    
                    result.Objects?.append(producto)
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
    
    func GetById(idProducto : Int) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdProducto,Nombre,PrecioUnitario,Stock,IdProveedor,IdDepartamento,Descripcion FROM Producto WHERE IdProducto = ?"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                var producto = Producto()
                sqlite3_bind_int(statement, 1, Int32(idProducto))
                if sqlite3_step(statement) == SQLITE_ROW{
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement, 2))
                    producto.Stock = Int(sqlite3_column_int(statement, 3))
                    producto.Proveedor = Proveedor()
                    producto.Proveedor.IdProveedor = Int(sqlite3_column_int(statement, 4))
                    producto.Departamento = Departamento()
                    producto.Departamento.IdDepartamento = Int(sqlite3_column_int(statement, 5))
                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 6))
                    
                    result.Object = producto
                    result.Correct = true
                }
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
