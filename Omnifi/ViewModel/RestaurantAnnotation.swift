//
//  RestaurantAnnotation.swift
//  Omnifi
//
//  Created by Vinicius Leal on 31/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import MapKit

// View Model class conforming to the MKAnnotation protocol to associate content with map pins.
// Also conforms to NSCoding protocol, that enables an object to be encoded and decoded
// for archiving and distribution.
class RestaurantAnnotation: NSObject, MKAnnotation, NSCoding {
    
    let title: String?
    let body: String
    let deliveryLink: String
    let latitude: String
    let longitude: String
    
    var coordinate: CLLocationCoordinate2D {
        return getCoordinate()
    }
    
    var hasDeliveryLink: Bool {
        return checkForLink()
    }
    
    init(restaurant: RestaurantElement) {
        
        self.title = restaurant.name
        
        self.latitude = restaurant.latitude
        
        self.longitude = restaurant.longitude
        
        self.deliveryLink = restaurant.deliveryLink
        
        //Deal with possible empty fields or HTML tags.
        if restaurant.body.isEmpty {
            self.body = "Description unavailable"
        } else {
            self.body = restaurant.body.removeHtml
        }
        
        super.init()
    }
    
    // Gets a coordinate in CLLocationCoordinate2D format.
    func getCoordinate() -> CLLocationCoordinate2D {
        
        let latitude = Double(self.latitude) ?? 0
        let longitude = Double(self.longitude) ?? 0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return coordinate
    }
    
    // Checks if object returned has delivery link. If there's a link, pin color is changed and button appears on DetailView.
    func checkForLink() -> Bool {
        if deliveryLink.isEmpty {
            return false
        }
        return true
    }
    
    // NSCoding protocol requirements
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(body, forKey: "body")
        aCoder.encode(deliveryLink, forKey: "deliveryLink")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.body = aDecoder.decodeObject(forKey: "body") as! String
        self.latitude = aDecoder.decodeObject(forKey: "latitude") as! String
        self.longitude = aDecoder.decodeObject(forKey: "longitude") as! String
        self.deliveryLink = aDecoder.decodeObject(forKey: "deliveryLink") as! String
    }
    
}
