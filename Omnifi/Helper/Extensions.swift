//
//  Extensions.swift
//  Omnifi
//
//  Created by Vinicius Leal on 31/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import UIKit

/// Font styles utilized with the font Family PingFangHK.
struct Font {
    
    static let medium = "Futura-Medium"
    
    static let condensedMedium = "Futura-CondensedMedium"
    
    static let bold = "Futura-Bold"
    
    static let condensedBold = "Futura-CondensedExtraBold"
}

/// Removes html tags from string.
extension String{
    var removeHtml: String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

/// Color palette used.
extension UIColor {
    static let mainPurple = UIColor(red:0.42, green:0.21, blue:0.46, alpha:1.0)
    
    static let strongPink = UIColor(red:0.93, green:0.19, blue:0.62, alpha:1.0)
    
    static let lightPink = UIColor(red:0.95, green:0.47, blue:0.58, alpha:1.0)
}

extension UIView {
    
    /// Anchors a view, with the possibility to add padding and specify a size.
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    // Fills a view's superview with it. Possible to add padding.
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    // Center view in superview, for both x and y coordinate.
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    // Center view in superview, for x coordinate.
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    // Center view in superview, for y coordinate.
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    // Adds a width constrain for the view.
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    // Adds a height constrain for the view.
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UILabel {
    convenience init(font: UIFont, numberOfLines: Int = 1, color: UIColor = .black) {
        self.init(frame: .zero)
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = .center
        self.textColor = color
    }
}

extension UIView {
    convenience init(color: UIColor, borderColor: CGColor, borderWidth: CGFloat) {
        self.init(frame: .zero)
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.backgroundColor = color
    }
}

extension UIButton {
    convenience init(title: String, cornerRadius: CGFloat, backgroundColor: UIColor) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.setTitleColor(.white, for: .normal)
        self.isHidden = true
        self.titleLabel?.font = UIFont(name: Font.medium, size: 18)!
    }
    
}
