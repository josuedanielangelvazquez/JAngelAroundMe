//
//  CategoriesViewModel.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 22/03/23.
//

import Foundation
import UIKit
import CoreData
class CategoriesViewModel{
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    func addCategories(categorie : String)->Result{

        var result = Result()
        do{
            let context = appdelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "CategoriesCoreData", in: context)
            let PlaceCoreData = NSManagedObject(entity: entidad!, insertInto: context)
            PlaceCoreData.setValue(categorie, forKey: "nameCategorie")
            try! context.save()
            result.Correct = true
        }
        catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    func getCategories()->Result{
        var result = Result()
        let context = appdelegate.persistentContainer.viewContext
        result.Objects = [String]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoriesCoreData")
        do{
            let places = try context.fetch(request)
            
            for objectcatgories  in places as! [NSManagedObject]{
                var categories = Categories(nameCategorie: "")
                categories.nameCategorie = objectcatgories.value(forKey: "nameCategorie") as! String
                result.Objects?.append(categories)
            }
            result.Correct = true
            
        }
        catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        
        return result
    }
    func Delete(idCategorie : Int)-> Result{
        var result = Result()
        let context  = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoriesCoreData")
        do{
            let categories = try context.fetch(request)
            let categorie = categories[idCategorie] as! NSManagedObject
            context.delete(categorie)
            do{
                try context.save()
                result.Correct = true
            }
            catch let error{
                result.Correct = false
                result.ErrorMessage = error.localizedDescription
                result.Ex = error
            }
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }
}
