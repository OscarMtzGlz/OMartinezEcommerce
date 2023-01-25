//
//  VentaViewModel.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 24/01/23.
//

import Foundation
import SQLite3

class VentaViewModel{
    let ventaModel : VentaProducto? = nil
    
    func Add(ventaProducto : VentaProducto) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO VentaProducto(Cantidad,IdProducto) VALUES (?,?)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_int(statement, 1, Int32(ventaProducto.Cantidad))
                sqlite3_bind_int(statement, 2, Int32(ventaProducto.Producto.IdProducto))
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else {
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
    
    func UpdateCantidad(ventaProducto : VentaProducto) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "Update VentaProducto SET Cantidad =\(ventaProducto.Cantidad) WHERE IdVentaProducto = \(ventaProducto.IdVentaProducto)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else {
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
    
    func Delete(idVentaProducto : Int) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "DELETE FROM VentaProducto WHERE IdVentaProducto = \(idVentaProducto)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
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
    
    func GetByIdProducto(idProducto : Int) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdVentaProducto,Cantidad,IdProducto FROM VentaProducto WHERE IdProducto = \(idProducto)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                var ventaProducto = VentaProducto()
                if sqlite3_step(statement) == SQLITE_ROW {
                    ventaProducto.IdVentaProducto = Int(sqlite3_column_int(statement, 0))
                    ventaProducto.Cantidad = Int(sqlite3_column_int(statement, 1))
                    ventaProducto.Producto = Producto()
                    ventaProducto.Producto.IdProducto = Int(sqlite3_column_int(statement, 2))
                    result.Object = ventaProducto
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
    
    func GetAll() -> Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdVentaProducto,Cantidad,VentaProducto.IdProducto,Producto.Nombre,Producto.PrecioUnitario,Producto.Descripcion,Producto.Imagen,Departamento.Nombre,Area.Nombre FROM VentaProducto INNER JOIN Producto ON Producto.IdProducto = VentaProducto.IdProducto INNER JOIN Departamento ON Producto.IdDepartamento = Departamento.IdDepartamento INNER JOIN Area ON Area.IdArea = Departamento.IdArea"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW {
                    var ventaProducto = VentaProducto()
                    
                    ventaProducto.IdVentaProducto = Int(sqlite3_column_int(statement, 0))
                    ventaProducto.Cantidad = Int(sqlite3_column_int(statement, 1))
                    ventaProducto.Producto = Producto()
                    ventaProducto.Producto.IdProducto = Int(sqlite3_column_int(statement, 2))
                    ventaProducto.Producto.Nombre = String(cString: sqlite3_column_text(statement, 3))
                    ventaProducto.Producto.PrecioUnitario = Double(sqlite3_column_double(statement, 4))
                    ventaProducto.Producto.Descripcion = String(cString: sqlite3_column_text(statement, 5))
                    if sqlite3_column_text(statement, 6) != nil{
                        ventaProducto.Producto.Imagen = String(cString: sqlite3_column_text(statement, 6))
                    }else{
                        ventaProducto.Producto.Imagen = ""
                    }
                    ventaProducto.Producto.Departamento = Departamento()
                    ventaProducto.Producto.Departamento.Nombre = String(cString: sqlite3_column_text(statement, 7))
                    ventaProducto.Producto.Departamento.Area = Area()
                    ventaProducto.Producto.Departamento.Area.Nombre = String(cString: sqlite3_column_text(statement, 8))
                    
                    ventaProducto.Total = Double(ventaProducto.Cantidad) * ventaProducto.Producto.PrecioUnitario
                    result.Objects?.append(ventaProducto)
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
    
    func AddVenta(venta: Venta) -> Result {
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Venta(IdUsuario,Total,IdMetodoPago) VALUES (?,?,?)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_int(statement, 1, Int32(venta.IdUsuario))
                sqlite3_bind_double(statement, 2, Double(venta.Total))
                sqlite3_bind_int(statement, 3, Int32(venta.MetodoPago.IdMetodoPago))
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else {
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
    
    func DeleteCarrito() -> Result{
        var result = Result()
        let context = DB.init()
        let query = "DELETE FROM VentaProducto"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
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
}
