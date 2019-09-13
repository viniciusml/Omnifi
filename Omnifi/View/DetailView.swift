//
//  DetailView.swift
//  Omnifi
//
//  Created by Vinicius Leal on 01/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import UIKit

/// A view that displays restaurant's details when popup is tapped.
///
class DetailView: UIView {
    
    // MARK: - Properties
    
    var restaurant: RestaurantAnnotation? {
        
        // Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value .
        didSet {
            guard let restaurant = restaurant else { return }
            bodyLabel.text = restaurant.body
            
            if restaurant.hasDeliveryLink {
                linkButton.isHidden = false
            }
        }
    }
    
    let bodyLabel = UILabel(font: UIFont(name: Font.medium, size: 20)!, numberOfLines: 0, color: .mainPurple)
    
    let linkButton = UIButton(title: "ORDER NOW", cornerRadius: 12, backgroundColor: .mainPurple)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 20
        layer.borderColor = UIColor.strongPink.cgColor
        layer.borderWidth = 8
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func setupUI() {
        
        addSubview(bodyLabel)
        bodyLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 20, bottom: 0, right: 20))
        
        addSubview(linkButton)
        linkButton.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 60))
        
        linkButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    // Opens browser with delivery link, when button tapped.
    @objc func didTapButton() {
        
        guard let restaurant = restaurant else { return }
        
        if let url = URL(string: restaurant.deliveryLink) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
