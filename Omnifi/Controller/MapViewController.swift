//
//  ViewController.swift
//  Omnifi
//
//  Created by Vinicius Leal on 31/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    // MARK: - Properties
    
    let defaults = UserDefaults.standard
    
    var restaurants = [RestaurantAnnotation]()
    
    let mapView = MKMapView()
    
    //Hide home indicator for better user experience.
    var isPrefersHomeIndicatorAutoHidden = false
    public override var prefersHomeIndicatorAutoHidden: Bool {
        return isPrefersHomeIndicatorAutoHidden
    }
    
    // Set initial location in Map
    let initialLocation = CLLocation(latitude: 52.071715, longitude: -1.317019)
    
    let regionRadius: CLLocationDistance = 100000
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isPrefersHomeIndicatorAutoHidden = true
        setNeedsUpdateOfHomeIndicatorAutoHidden()
        
        tryLoadingDataOffline()
        
        self.title = "RESTAURANTS"
        
        view.addSubview(mapView)
        mapView.fillSuperview()
        
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
    }
    
    // MARK: - Helper functions
    
    // Centers map on a specific location. Location chosen was the one containing large number of restaurants.
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // MARK: - API
    
    func fetchRestaurantList() {
        
        Service.shared.fetchRestaurantList() { (res) in
            switch res {
            case .success(let restaurantElements):
                self.restaurants = restaurantElements.map({ return RestaurantAnnotation(restaurant: $0) })
            case .failure(let err):
                print("Failure to fetch product:", err)
                Alert().showBasicAlert(title: "Network Error", message: "Failed to load restaurants. Try again later.", vc: self)
            }
            
            DispatchQueue.main.async {

                self.mapView.addAnnotations(self.restaurants)
                self.cacheData(self.restaurants)
            }
            
        }
    }
    
    
    // MARK: - Data Persistance
    
    // Saves data after first API fetch.
    func cacheData(_ restaurants: [RestaurantAnnotation]) {
        
        do {
            let myData = try NSKeyedArchiver.archivedData(withRootObject: restaurants, requiringSecureCoding: false)
            
            defaults.set(myData, forKey: "SavedRestaurants")
            
        } catch let error {
            print("error during archive: \(error)")
        }
    }
    
    // Check if there is data saved. If there is, uses it, so the app runs offline after the first API call. If there is not data available, fetchs data from API.
    func tryLoadingDataOffline() {
        
        guard let retrievedData = defaults.object(forKey: "SavedRestaurants") as? NSData else {
            print("'Restaurants' not found in UserDefaults")
            
            fetchRestaurantList()
            return
        }
        
        guard let retrievedRestaurants = NSKeyedUnarchiver.unarchiveObject(with: retrievedData as Data) as? [RestaurantAnnotation]
            else {
                print("Could not unarchive from retrievedData")
                return
        }
        
        restaurants = retrievedRestaurants
        mapView.addAnnotations(restaurants)
    }
}

// MARK: - MKMapViewDelegate Functions

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? RestaurantAnnotation else { return nil }
       
        let identifierWithDelivery = "markerD"
        let identifierNoDelivery = "marker"
        
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifierWithDelivery)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
            
            // Change annotation color based on delivery link availability.
        } else if annotation.hasDeliveryLink {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifierWithDelivery)
            view.tintColor = .mainPurple
            view.markerTintColor = .mainPurple
            
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifierNoDelivery)
            view.tintColor = .lightPink
            view.markerTintColor = .lightPink
        }
        
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return view
    }
    
    // Pushes Detail View Controller after .detailDisclosure button is tapped on marker.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        let restaurantTapped = view.annotation as! RestaurantAnnotation

        let detailController = DetailViewController(restaurant: restaurantTapped)
        detailController.title = restaurantTapped.title?.uppercased()
        
        navigationController?.pushViewController(detailController, animated: true)

    }
}
