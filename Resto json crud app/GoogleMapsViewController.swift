//
//  GoogleMapsViewController.swift
//  Resto json crud app
//
//  Created by hint on 23/08/18.
//  Copyright © 2018 ZidniRyi. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import Alamofire
import SwiftyJSON


class GoogleMapsViewController: UIViewController, CLLocationManagerDelegate {
    
//    Deklarasi Global
    
    var lat : Double? = nil
    var lon : Double? = nil
    
//
    
    var gps = CLLocationManager()
    
    var data = [[String : String]]()
    
    

    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var lblJarak: UILabel!
    
    @IBOutlet weak var lblWaktu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gps.delegate = self
        
        gps.requestLocation()
        gps.startUpdatingHeading()
        gps.requestAlwaysAuthorization()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get koordinat terakhir di update
        let coord = locations.last?.coordinate
         lat = coord?.latitude
         lon = coord?.longitude
        
        addMarker(lat: lat!, lon: lon!)
        
        route()
    
    }
    
//    Todo Ambil dari endpoint google Duumies
    
    func route(){
        
//        Bikin variabel
        let posisi1 = String(lat!) + "," + String(lon!)
        let posisi2 = "-6.1753924,106.8271528"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + posisi1 + "&destination=" + posisi2
        print(url)
        Alamofire.request(url).responseJSON { (responseRoute) in
            
//            Get JSON dari route Kaya buat
          let allJson = JSON(responseRoute.result.value as Any)
          let routes =  allJson["routes"].arrayValue
          let object0 = routes[0]
            
            
//            Ambil Jarak sama durations
            let leg0 = object0["legs"].arrayValue
            let object02 = leg0[0]["distance"].dictionaryValue
            let jarak = object02["text"]?.stringValue
              self.lblJarak.text = jarak
            
//            Ambil
            let object03 = leg0[0]["duration"].dictionaryValue
            let waktu = object03["text"]?.stringValue
            self.lblWaktu.text = waktu
            
            
            
          let overview =  object0["overview_polyline"].dictionaryValue
          let points = overview["points"]?.stringValue
            


           
           
//           Dimasukan GMS untuk encript
            
            let path = GMSPath(fromEncodedPath: points!)
            let poly = GMSPolyline(path: path)
            poly.strokeColor = (UIColor.cyan)
            poly.strokeWidth = 3
            poly.geodesic = true
            
            poly.map = self.map
            
            
        }
    }
    
    func  addMarker(lat : Double, lon : Double){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 17.0)
        //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //        view = mapView
        
        map.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.title = "Jakarta"
        marker.snippet = "Indonesia"
        marker.map = map
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
