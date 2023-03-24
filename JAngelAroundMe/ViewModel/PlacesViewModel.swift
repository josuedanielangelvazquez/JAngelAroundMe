//
//  PlacesViewModel.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 23/03/23.
//

import Foundation
class PlaceViewModel{
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
 

}
