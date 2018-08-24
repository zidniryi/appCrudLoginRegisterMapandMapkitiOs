//
//  MapkitViewController.swift
//  Resto json crud app
//
//  Created by hint on 23/08/18.
//  Copyright © 2018 ZidniRyi. All rights reserved.
//

import UIKit
import MapKit

@available(iOS 10.0, *)
class MapkitViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var labelJarak: UILabel!
    
    @IBOutlet weak var labelWaktu: UILabel!
    
    @IBOutlet weak var mapkit: MKMapView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapkit.delegate = self
//-7.3892507,109.6886173 sury yudha
//-7.3905539,109.6846924, seruling mas
        
//        Bikin Koordinat untuk awal dan akhirnya
        let source = CLLocationCoordinate2D(latitude: -7.3892507, longitude: 109.6886173)
        let destination = CLLocationCoordinate2D(latitude: -7.3905539, longitude: 109.6846924)
        
//        Bikin marker atau pin tanda awal dan akhir
        let  pinSource = MKPointAnnotation()
//        Ngasih title
        pinSource.title = "Ini Awal Bang"
        pinSource.coordinate = source
        
        let  pinDestinations = MKPointAnnotation()
        //        Ngasih title
        pinDestinations.title = "Ini Tujuan Bang"
        pinDestinations.coordinate = destination
        
//        Pin yang baru kita bikin inputin di mapnya
        mapkit.showAnnotations([pinSource,pinDestinations], animated: true)
        
//        KIta konvert coordinat jadi placemarker
        let source1 = MKPlacemark(coordinate : source)
        let dest1 = MKPlacemark(coordinate: destination)
        
//        Kita konver place marke menuju item
        let itemSource = MKMapItem(placemark : source1)
        let itemDestinantion = MKMapItem(placemark : dest1)
        
//     map item di ekseskusi mengggunakn mk direction request
        let mkRequest = MKDirectionsRequest()
        mkRequest.source = itemSource
        mkRequest.destination = itemDestinantion
        mkRequest.transportType = .automobile

        
//        Untuk menggambarkan
        let direction = MKDirections(request: mkRequest)
        
//        ambil repsones rute
        direction.calculate { (responsemapkit, error) in
            
            let jarak = responsemapkit?.routes[0].distance
            let distance = Double(jarak!)
            let d = distance/1000
            self.labelJarak.text = String(d) + "Km"
            
       
            
            
            
            let route = responsemapkit?.routes[0].polyline
            
//            Gambarkan route
            self.mapkit.add(route!, level: .aboveRoads)
            
            
        }

        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let changeroute = MKPolylineRenderer(overlay: overlay)
        changeroute.lineWidth = 4.0
        changeroute.strokeColor = UIColor.brown
        
        return changeroute
    }

}
