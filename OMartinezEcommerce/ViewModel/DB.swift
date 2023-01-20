//
//  DB.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 27/12/22.
//

import Foundation
import SQLite3

class DB{
    //let path : String = "OMartinezEcommerce2.sql"
    let namedb : String = "OMartinezEcommerce2.sql"
    var db : OpaquePointer? = nil
    init(){
        db = OpenConexion(databaseName: namedb)
    }
    func OpenConexion(databaseName: String) -> OpaquePointer? {
        var databasePointer : OpaquePointer?
        let documentDatabasePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(databaseName).path
        if FileManager.default.fileExists(atPath: documentDatabasePath) {
            print("Database exists")
        }else{
            guard let bundleDatabasePath = Bundle.main.resourceURL?.appendingPathComponent(databaseName).path else{
                print("Unwrapping error: bundle path doesn't exists")
                return nil
            }
            do{
                try FileManager.default.copyItem(atPath: bundleDatabasePath, toPath: documentDatabasePath)
                print("Database created")
            }catch {
                print("Error")
                return nil
            }
        }
        if sqlite3_open(documentDatabasePath, &databasePointer) == SQLITE_OK {
            print("Open database")
            print(documentDatabasePath)
        }else{
            print("Could not open db")
        }
        
        return databasePointer
//        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(self.path)
//
//        var db: OpaquePointer? = nil
//
//        if sqlite3_open(filePath.path, &db) == SQLITE_OK{
//            print("Conexion correcta")
//            print(filePath)
//            return db
//        }else{
//            print("Conexion fallida")
//            return nil
//        }
    }
}
