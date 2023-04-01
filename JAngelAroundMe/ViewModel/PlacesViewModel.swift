//
//  PlacesViewModel.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 23/03/23.
//

import Foundation
import CoreData
import UIKit
class PlaceViewModel{
    let appdelegate = UIApplication.shared.delegate as! AppDelegate

    func getplaces(Categorie : String, places : @escaping(PlaceModel?)->Void){
        var result = Result()
        let urlsession = URLSession.shared
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(Categorie)%20in%20CDMX&key=AIzaSyDLGtXTw5rvpXPxSYRufGGYrv1kPXm5VY8")
        urlsession.dataTask(with: url!){
            data, response, error in
            
            if let safedata = data{
                let json = self.parsejson(data: safedata)
                places(json)
            }
        }.resume()
    }
    func parsejson(data : Data) ->PlaceModel?{
        let decodable = JSONDecoder()
        do{
            let request = try decodable.decode(PlaceModel.self, from: data)
            let places = PlaceModel(results: request.results)
            print(places.results)
            return places
        }
        catch let error{
            print(error.localizedDescription)
            return nil
        }
    }
    func parsejsondetail(data : Data) -> PlaceDetailModel?{
        let decodable = JSONDecoder()
        do{
            let request = try decodable.decode(PlaceDetailModel.self, from: data)
            let place = PlaceDetailModel(result: request.result)
            print(place.result)
            return place
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    func getbyid(idPlace : String, place : @escaping(PlaceDetailModel)->Void){
        let urlsession = URLSession.shared
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?&place_id=\(idPlace)&key=AIzaSyDLGtXTw5rvpXPxSYRufGGYrv1kPXm5VY8")
        urlsession.dataTask(with: url!){
            data, response, error in
            if let safedata = data{
                let json = self.parsejsondetail(data: safedata)
                place(json!)
            }
        }.resume()
    }
    func addfavorites(idplace : String, resultC : @escaping(Result)->Void){
        
        getbyid(idPlace: idplace) { objectplace in
            DispatchQueue.main.async { [self] in
                var result = Result()
                do{
                    let context = appdelegate.persistentContainer.viewContext
                    let entidad = NSEntityDescription.entity(forEntityName: "Places", in: context)
                    let entidadcoredata = NSManagedObject(entity: entidad!, insertInto: context)
                    entidadcoredata.setValue(objectplace.result?.place_id, forKey: "idplace")
                    entidadcoredata.setValue(objectplace.result?.name, forKey: "name")
                    entidadcoredata.setValue(objectplace.result?.vicinity, forKey: "address")
                    try!context.save()
                    result.Correct = true
                      resultC(result)
                }
                catch let error{
                    result.Correct = false
                    result.Ex = error
                    result.ErrorMessage = error.localizedDescription
                    resultC(result)
                }
            }
        }
     
        
    }
    func getallfavorites()->Result{
        var result = Result()
        let context = appdelegate.persistentContainer.viewContext
        result.Objects = [String]()
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        do{
            let places = try context.fetch(request)
            
            for objectcatgories  in places as! [NSManagedObject]{
                var categories = results(formatted_address: "", geometry: geometry(), name: "", opening_hours: opening_hours(), place_id: "")
                categories.name = objectcatgories.value(forKey: "name") as! String
                categories.place_id = objectcatgories.value(forKey: "idplace") as! String
                categories.formatted_address = objectcatgories.value(forKey: "address") as! String
                
                result.Objects?.append(categories)
            }
            result.Correct = true
            result.Correct = true
        }
        catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }

}
