//
//  UIView.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

public extension UIView {
    
    // MARK: - Properties
    
    /// safeTopAnchor
    var safeTopAnchor: NSLayoutYAxisAnchor { return self.safeAreaLayoutGuide.topAnchor }
    
    /// safeLeftAnchor
    var safeLeftAnchor: NSLayoutXAxisAnchor { return self.safeAreaLayoutGuide.leftAnchor }
    
    /// safeRightAnchor
    var safeRightAnchor: NSLayoutXAxisAnchor { return self.safeAreaLayoutGuide.rightAnchor }
    
    /// safeBottomAnchor
    var safeBottomAnchor: NSLayoutYAxisAnchor { return self.safeAreaLayoutGuide.bottomAnchor }
    
    /// safeCenterXAnchor
    var safeCenterXAnchor: NSLayoutXAxisAnchor { return self.safeAreaLayoutGuide.centerXAnchor }
    
    /// safeCenterYAnchor
    var safeCenterYAnchor: NSLayoutYAxisAnchor { return self.safeAreaLayoutGuide.centerYAnchor }
    
    /// cornerRadius
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// borderWidth
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// borderColor
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // MARK: - Public Methods
    
    /// Anchor View with top and bottom
    /// - Parameters:
    ///   - top: top
    ///   - bottom: bottom
    ///   - paddingTop: paddingTop
    ///   - paddingBottom: paddingBottom
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = .zero,
                paddingBottom: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top { topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true }
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true }
    }
    
    /// Anchor View with left and right
    /// - Parameters:
    ///   - left: left
    ///   - right: right
    ///   - paddingLeft: paddingLeft
    ///   - paddingRight: paddingRight
    func anchor(left: NSLayoutXAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingLeft: CGFloat = .zero,
                paddingRight: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let left = left { leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true }
        if let right = right { rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true }
    }
    
    /// Anchor View with horizontal and vertical
    /// - Parameters:
    ///   - horizontal: horizontal
    ///   - vertical: vertical
    ///   - paddingHorizontal: paddingHorizontal
    ///   - paddingVertical: paddingVertical
    func anchor(horizontal: NSLayoutXAxisAnchor? = nil,
                vertical: NSLayoutYAxisAnchor? = nil,
                paddingHorizontal: CGFloat = .zero,
                paddingVertical: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let horizontal = horizontal { centerXAnchor.constraint(equalTo: horizontal, constant: paddingHorizontal).isActive = true }
        if let vertical = vertical { centerYAnchor.constraint(equalTo: vertical, constant: paddingVertical).isActive = true }
    }
    
    /// Anchor View with width and height
    /// - Parameters:
    ///   - width: width
    ///   - height: height
    func anchor(width: CGFloat = .zero,
                height: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if  height != .zero { heightAnchor.constraint(equalToConstant: height).isActive = true }
        if  width != .zero { widthAnchor.constraint(equalToConstant: width).isActive = true }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let cornerRadii = CGSize(width: radius, height: radius)
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
    
    func roundCorners(maskedCorner: CACornerMask?, radius: CGFloat) {
        if let maskedCorners = maskedCorner {
            if #available(iOS 11.0, *) {
                clipsToBounds = false
                layer.cornerRadius = radius
                layer.maskedCorners = maskedCorners
            } else {
                let rectShape = CAShapeLayer()
                rectShape.bounds = frame
                rectShape.position = center
                rectShape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
                layer.mask = rectShape
            }
        }
    }
}
