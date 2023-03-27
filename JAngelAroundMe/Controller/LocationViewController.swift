//
//  LocationViewController.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 24/03/23.
//

import UIKit
import CoreLocation
import MapKit


class LocationViewController: UIViewController {

    @IBOutlet weak var Maplocation: MKMapView!
    var categoriesname = ""
    var placesviewmodel = PlaceViewModel()
    var locationManager: CLLocationManager!
    var locations = [results]()
    var arrayAnnotation = [MKPointAnnotation]()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        locationManager = CLLocationManager()
          locationManager.requestWhenInUseAuthorization()
        
        loadData()
    }
    
    
    func loadData(){
        
        placesviewmodel.getplaces(Categorie: categoriesname) { places in
            DispatchQueue.main.async { [self] in
                locations = places?.results as! [results]
                for locationsarray in locations{
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: (locationsarray.geometry?.location?.lat)!
                                                                   , longitude: (locationsarray.geometry?.location?.lng)!)
                    annotation.title = locationsarray.name
                    arrayAnnotation.append(annotation)
                }
                for annotationmap in arrayAnnotation{
                    Maplocation.addAnnotation(annotationmap)
                }
            }

                
                
                
            }
        }
        
        
        
        
        
       
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
