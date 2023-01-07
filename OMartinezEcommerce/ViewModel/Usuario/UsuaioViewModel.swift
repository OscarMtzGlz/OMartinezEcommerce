//
//  UsuaioViewModel.swift
//  OMartinezEcommerce
//
//  Created by MacBookMBA2 on 06/01/23.
//
import CoreData
import UIKit

class UsuarioViewModel{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(usuario : UsuarioC) -> Result {
        var result = Result()
        do{
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "Usuario", in: context)
            let usuarioCoreData = NSManagedObject(entity: entidad!, insertInto: context)
            
            usuarioCoreData.setValue(usuario.Nombre, forKey: "nombre")
            usuarioCoreData.setValue(usuario.ApellidoPaterno, forKey: "apellidoPaterno")
            usuarioCoreData.setValue(usuario.ApellidoMaterno, forKey: "apellidoMaterno")
            usuarioCoreData.setValue(usuario.UserName, forKey: "userName")
            usuarioCoreData.setValue(usuario.Password, forKey: "password")
            usuarioCoreData.setValue(usuario.Email, forKey: "email")
            usuarioCoreData.setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
            usuarioCoreData.setValue(usuario.Sexo, forKey: "sexo")
            usuarioCoreData.setValue(usuario.CURP, forKey: "curp")
            usuarioCoreData.setValue(usuario.Celular, forKey: "celular")
            usuarioCoreData.setValue(usuario.Telefono, forKey: "telefono")
            usuarioCoreData.setValue(usuario.Imagen, forKey: "imagen")
            
            try context.save()
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func GetAll() -> Result{
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
        do{
            let usuarios = try context.fetch(request)
            result.Objects = [UsuarioC]()
            for objUsuario in usuarios as! [NSManagedObjectID]{
                var usuario = UsuarioC()
                usuario.Nombre = objUsuario.value(forKey: "nombre") as! String
                usuario.ApellidoPaterno = objUsuario.value(forKey: "apellidoPaterno") as! String
                usuario.ApellidoMaterno = objUsuario.value(forKey: "apellidoMaterno") as! String
                usuario.UserName = objUsuario.value(forKey: "userName") as! String
                usuario.Email = objUsuario.value(forKey: "email") as! String
                usuario.Password = objUsuario.value(forKey: "password") as! String
                usuario.Sexo = objUsuario.value(forKey: "sexo") as! String
                usuario.CURP = objUsuario.value(forKey: "curp") as! String
                usuario.Telefono = objUsuario.value(forKey: "telefono") as! String
                usuario.Celular = objUsuario.value(forKey: "celular") as! String
                usuario.Imagen = objUsuario.value(forKey: "imagen") as! String
                usuario.FechaNacimiento = objUsuario.value(forKey: "fechaNacimiento") as! Date
                
                result.Objects?.append(usuario)
            }
            result.Correct = true
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
}

//let id = Item.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1] -- idcoredata
