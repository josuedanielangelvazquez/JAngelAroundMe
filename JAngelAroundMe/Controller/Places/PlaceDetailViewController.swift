//
//  PlaceDetailViewController.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 23/03/23.
//

import UIKit
import MapKit
import CoreLocation
class PlaceDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var arraysectionss = [PlaceArrya]()
    var idPlace = ""
    var lat = 0.0
    var lng = -0.0
    var latuser = 0.0
    var lnguser = 0.0
    var placesviewmodel  = PlaceViewModel()
    var locationManager: CLLocationManager!

    @IBOutlet weak var MapaMapkit: MKMapView!
    @IBOutlet weak var TableDetail: UITableView!
    
    override func viewDidLoad() {

        MapaMapkit.delegate = self

            locationManager = CLLocationManager()
              locationManager.requestWhenInUseAuthorization()
        TableDetail.delegate = self
        TableDetail.dataSource = self
        view.addSubview(TableDetail)
        MapaMapkit.delegate = self

        super.viewDidLoad()
      
        TableDetail.register(UINib(nibName: "DetailTableViewCell", bundle: .main), forCellReuseIdentifier: "Detailcel")
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        locationManager

    }
   
    override func viewWillAppear(_ animated: Bool) {
        loadData()
      
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polylineOverlay = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polylineOverlay)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latuser = locValue.latitude
        lnguser = locValue.longitude
        
    }
    
    
    func getDirections() {
        
              
              let sourceLocation = CLLocationCoordinate2D(latitude: latuser, longitude: lnguser)
              let destinationLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
              
              let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
              let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
              
              let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
              let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
              
              let directionsRequest = MKDirections.Request()
              directionsRequest.source = sourceMapItem
              directionsRequest.destination = destinationMapItem
              directionsRequest.transportType = .automobile 
              
              let directions = MKDirections(request: directionsRequest)
              directions.calculate { (response, error) in
                  guard let response = response else {
                      if let error = error {
                          print("Error calculating directions: \(error.localizedDescription)")
                      }
                      return
                  }
                  
                  let route = response.routes[0]
                  self.MapaMapkit.addOverlay(route.polyline, level: .aboveRoads)
                  
                  let rect = route.polyline.boundingMapRect
                  self.MapaMapkit.setRegion(MKCoordinateRegion(rect), animated: true)
              }
       }
    
    func loadData(){
        placesviewmodel.getbyid(idPlace: idPlace) { Detail in
            DispatchQueue.main.async { [self] in
                lat = (Detail.result.geometry?.location?.lat)!
                lng = (Detail.result.geometry?.location?.lng)!
                let annotation1 = MKPointAnnotation()
                       annotation1.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                annotation1.title = Detail.result.name // Optional
                    //   annotation1.subtitle = "Example 0 subtitle" // Optional
                       self.MapaMapkit.addAnnotation(annotation1)
                let result = generatearray(placedetailmodel: Detail)
                if result != nil{
                    arraysectionss = result as! [PlaceArrya]
                    TableDetail.reloadData()
                }
            
            }
        }
    }
    func generatearray(placedetailmodel : PlaceDetailModel)->[PlaceArrya]{
      var arraysections = [PlaceArrya]()
        for secion in 0...4 {
            if secion == 0{
                var array = [String]()
                array.append(placedetailmodel.result.name ?? "Not Information")
                let seccion =  PlaceArrya(nameseccion: "SPECIAL OFFER", sectionarray: array)
                arraysections.append(seccion)
            }
            if secion == 1{
                var array = [String]()
                array.append(placedetailmodel.result.formatted_phone_number ?? "Not information")
                array.append(placedetailmodel.result.website ?? "Not Information")
                let seccion = PlaceArrya(nameseccion: "CONTACTS", sectionarray: array)
                arraysections.append(seccion)
            }
            if secion == 2{
                var array = [String]()
                array.append(placedetailmodel.result.vicinity ?? "Not information")
                let seccion = PlaceArrya(nameseccion: "DIRECTION", sectionarray: array)
                arraysections.append(seccion)
            }
            if secion == 3{
                let seccion = PlaceArrya(nameseccion: "HOURS", sectionarray: placedetailmodel.result.current_opening_hours.weekday_text)
                arraysections.append(seccion)
            }
        }
        
    return arraysections
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arraysectionss.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arraysectionss[section].nameseccion
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraysectionss[section].sectionarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Detailcel", for: indexPath as IndexPath) as! DetailTableViewCell
        cell.Detaillbl.text = arraysectionss[indexPath.section].sectionarray[indexPath.row]
        if indexPath.section == 0{
            cell.ImageIcons.isHidden = true
            cell.ViewImageIcons.isHidden = true
        }
        if indexPath.section == 1{
            cell.ImageIcons.isHidden = false
            cell.ViewImageIcons.isHidden = false
        }
        if indexPath.section == 2{
            cell.ImageIcons.isHidden = true
            cell.ViewImageIcons.isHidden = true
        }
        if indexPath.section == 3{
            cell.ImageIcons.isHidden = true
            cell.ViewImageIcons.isHidden = true
            cell.Detaillbl.center
        }
        
        return cell
    }
    
    @IBAction func Rutaaction(_ sender: Any) {

        getDirections()
    }
    
}

