//
//  PlaceModel.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 22/03/23.
//

import Foundation
struct PlaceModel : Codable{
    var results : [results]
}

struct results : Codable{
    var formatted_address : String?
    var geometry : geometry?
    var name : String?
    var opening_hours : opening_hours?
    var place_id : String?
}
struct opening_hours : Codable{
    var open_now : Bool?
}

struct geometry : Codable{
    var location : location?
}
struct location : Codable{
    var lat : Double?
    var lng : Double?
}

/////Detail Places /////
struct PlaceDetailModel : Codable{
    var result : result
}
struct result : Codable{
    var current_opening_hours : current_opening_hours
    var formatted_phone_number : String?
    var geometry : geometry?
    var name : String?
    var place_id : String?
    var website : String?
    var vicinity : String?
}
struct current_opening_hours : Codable{
    var weekday_text : [String]
    
}


///Detail array ///
struct PlaceArrya {
    var nameseccion : String
    var sectionarray : [String]
}

