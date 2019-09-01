//
//  Service.swift
//  Omnifi
//
//  Created by Vinicius Leal on 31/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation

/// Fetch data from API.
class Service {
    
    static let shared = Service()
    
    /// Fetch list of restaurants.
    func fetchRestaurantList(completion: @escaping (Result<[RestaurantElement], Error>) -> ()) {
        
        guard let url = URL(string: "https://www.frankieandbennys.com/trg_restaurant_feed/JSON") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            // Handle error
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                let restaurantElements = try JSONDecoder().decode([RestaurantElement].self, from: data!)
                completion(.success(restaurantElements))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
            }.resume()
    }
}
