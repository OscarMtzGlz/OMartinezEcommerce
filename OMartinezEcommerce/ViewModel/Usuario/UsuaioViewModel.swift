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
            for objUsuario in usuarios as! [NSManagedObject]{
                var usuario = UsuarioC()
                usuario.IdUsuario = Int( objUsuario.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!
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
    
    func GetById(posicionUsuario : Int) -> Result{
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
        do{
            let usuarios = try context.fetch(request) as! [NSManagedObject]
            var usuario = UsuarioC(
                IdUsuario: Int(usuarios[posicionUsuario].objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!,
                UserName: usuarios[posicionUsuario].value(forKey: "userName") as! String,
                Nombre: usuarios[posicionUsuario].value(forKey: "nombre") as! String,
                ApellidoPaterno: usuarios[posicionUsuario].value(forKey: "apellidoPaterno") as! String,
                ApellidoMaterno: usuarios[posicionUsuario].value(forKey: "apellidoMaterno") as! String,
                Email: usuarios[posicionUsuario].value(forKey: "email") as! String,
                Password: usuarios[posicionUsuario].value(forKey: "password") as! String,
                FechaNacimiento: usuarios[posicionUsuario].value(forKey: "fechaNacimiento") as! Date,
                Sexo: usuarios[posicionUsuario].value(forKey: "sexo") as! String,
                Telefono: usuarios[posicionUsuario].value(forKey: "telefono") as! String,
                Celular: usuarios[posicionUsuario].value(forKey: "celular") as! String,
                CURP: usuarios[posicionUsuario].value(forKey: "curp") as! String,
                Imagen: usuarios[posicionUsuario].value(forKey: "imagen") as! String)
            result.Object = usuario
            result.Correct = true
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func Update(usuario : UsuarioC) -> Result {
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Usuario")
        
        do{
            let test = try context.fetch(request)
            let objUpdate = test[usuario.IdUsuario] as! NSManagedObject
            objUpdate.setValue(usuario.Nombre, forKey: "nombre")
            objUpdate.setValue(usuario.ApellidoPaterno, forKey: "apellidoPaterno")
            objUpdate.setValue(usuario.ApellidoMaterno, forKey: "apellidoMaterno")
            objUpdate.setValue(usuario.UserName, forKey: "userName")
            objUpdate.setValue(usuario.Password, forKey: "password")
            objUpdate.setValue(usuario.Email, forKey: "email")
            objUpdate.setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
            objUpdate.setValue(usuario.Sexo, forKey: "sexo")
            objUpdate.setValue(usuario.CURP, forKey: "curp")
            objUpdate.setValue(usuario.Celular, forKey: "celular")
            objUpdate.setValue(usuario.Telefono, forKey: "telefono")
            objUpdate.setValue(usuario.Imagen, forKey: "imagen")
            do{
                try context.save()
                result.Correct = true
            }catch let error1{
                result.Correct = false
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func Delete(posicionUsuario : Int) -> Result {
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
        do{
            let test = try context.fetch(request)
            let objDelete = test[posicionUsuario] as! NSManagedObject
            context.delete(objDelete)
            do{
                try context.save()
                result.Correct = true
            }catch let error1{
                result.Correct = false
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
}
