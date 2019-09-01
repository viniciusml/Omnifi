//
//  DetailViewController.swift
//  Omnifi
//
//  Created by Vinicius Leal on 31/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    // MARK: Properties
    
    var restaurant: RestaurantAnnotation?
    
    var detailView = DetailView()
        
    // MARK: - Initializer
    
    init(restaurant: RestaurantAnnotation) {
        super.init(nibName: nil, bundle: nil)
        
        detailView.restaurant = restaurant
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(detailView)
        detailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }

}
