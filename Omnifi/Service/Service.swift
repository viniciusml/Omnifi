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
    
    private init() {}
    /// Fetch list of restaurants.
    ///
    /// It accepts a Result tipe: A value that represents either a sucess or a failure,
    /// including an associated value with each case.
    ///
    /// It has two generics inside, one is your object, and the other is an error.
    func fetchRestaurantList(completion: @escaping (Result<[RestaurantElement], Error>) -> ()) {
        
        guard let url = URL(string: "https://www.frankieandbennys.com/trg_restaurant_feed/JSON") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            // Handle error
            if let err = err {
                // You can call one parameter in completion, instead of 2.
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
