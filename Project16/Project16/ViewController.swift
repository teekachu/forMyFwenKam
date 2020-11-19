//
//  ViewController.swift
//  Project16
//
//  Created by meekam okeke on 11/16/20.
//
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate{
    
    
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map type", style: .plain, target: self, action: #selector(changeMapType))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 summer olympics.", website: "wikipedia.org/wiki/London")
        let oslo  = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "founded over a thousand years ago.", website: "wikipedia.org/wiki/Oslo" )
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the city of light.", website: "wikipedia.org/wiki/Paris")
        let rome =  Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Home to the Vatican city.", website: "wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", website: "wikipedia.org/wiki/Washington")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = .blue
        return annotationView
        
    }
    
    
    @objc func changeMapType(_ sender: UIBarButtonItem){
        let ac = UIAlertController(title: "Map Type", message: nil, preferredStyle: .alert)
        /// so this is how you use a closure to do the same thing.
        /// The underscore  is because i didn't give it a name , since we don't need one and we just need the below code to execute
        /// obviously your way works perfect, just a personal preference on which you like more.
        ac.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: { (_) in
            self.mapView.mapType = .hybridFlyover
        }))
        
        //        ac.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: hybridFlyover))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: satellite))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: hybrid))
        ac.addAction(UIAlertAction(title: "Muted Standard", style: .default, handler: mutedStandard))
        ac.addAction(UIAlertAction(title: "Satellite FLyover", style: .default, handler: satelliteFlyover))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: standard))
        present(ac, animated: true)
    }
    //    func hybridFlyover(action: UIAlertAction){
    //        self.mapView.mapType = .hybridFlyover
    //    }
    func satellite(action: UIAlertAction){
        self.mapView.mapType = .satellite
    }
    func hybrid(action: UIAlertAction){
        self.mapView.mapType = .hybrid
    }
    func mutedStandard(action: UIAlertAction){
        self.mapView.mapType = .mutedStandard
    }
    func satelliteFlyover(action: UIAlertAction){
        self.mapView.mapType = .satelliteFlyover
    }
    func standard(action: UIAlertAction){
        self.mapView.mapType = .standard
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else{return}
        
        /// i added a place name here to pass into the ac,
        /// so instead of open page, users know which page they are opening for what city
        let placeName = capital.title
        let placeInfo = capital.website
        
        /// pass the name and info into your alertcontroller for user feedback,
        /// i personally also changed the preferred style to actionSheet instead of alert. In my opinion it makes more sense and also prettier
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .actionSheet)
        //        ac.addAction(UIAlertAction(title: placeInfo, style: .default, handler: openPage))
        
        /// instead of creating a new openPage method, use handler closure included in the addAction() . See below
        ac.addAction(UIAlertAction(title: placeInfo, style: .default, handler: { (_) in
            
            /// ( First, I gave the detailVC's storyboard an identifier). The code basically says:
            /// if there is a storyboard with identifier called "wikiPage", put it in a constant called "vc" and make it a DetailViewController
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "wikiPage") as? DetailViewController {
                
                /// Then, inside that detailVC, if there is a variable called selectedCapitalCity , pass in the placeName declared above into it. and show me that detailVC.
                vc.selectedCityName = placeName
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }))
        
        /// this action is just to dismiss the alert.
        ac.addAction(UIAlertAction(title: "Okay", style: .cancel))
        present(ac, animated: true)
    }
}


