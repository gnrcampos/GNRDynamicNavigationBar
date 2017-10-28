//
//  GNRColorComponents.swift
//  GNRDynamicNavigationBar
//
//  Created by Gustavo Sgarbi Campos on 10/28/17.
//  Copyright © 2017 Gustavo Sgarbi Campos. All rights reserved.
//

import Foundation

public struct GNRColorComponents: Equatable {
    //MARK: Instance properties
    /**
     Between 0 and 255
     **/
    public let r: CGFloat
    /**
     Between 0 and 255
     **/
    public let g: CGFloat
    /**
     Between 0 and 255
     **/
    public let b: CGFloat
    /**
     Between 0 and 1
     **/
    public let alpha: CGFloat
    
    //MARK: Calculated properties
    public var color: UIColor {
        return UIColor(red: self.r/255.0, green: self.g/255.0, blue: self.b/255.0, alpha: self.alpha)
    }
    
    public var inverse: GNRColorComponents {
        return GNRColorComponents(
            r: 255 - self.r,
            g: 255 - self.g,
            b: 255 - self.b,
            alpha: 1 - self.alpha)
    }
    
    public var rgbInverse: GNRColorComponents {
        return GNRColorComponents(
            r: 255 - self.r,
            g: 255 - self.g,
            b: 255 - self.b,
            alpha: self.alpha)
    }
    
    //MARK: Init
    public init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.r = max(0, min(255, r))
        self.g = max(0, min(255, g))
        self.b = max(0, min(255, b))
        self.alpha = max(0, min(1, alpha))
    }
    
    //MARK: Operators
    public static func +(left: GNRColorComponents, right: GNRColorComponents) -> GNRColorComponents {
        return GNRColorComponents(
            r: right.r + left.r,
            g: right.g + left.g,
            b: right.b + left.b,
            alpha: right.alpha + left.alpha)
    }
    
    public static func *(left: CGFloat, right: GNRColorComponents) -> GNRColorComponents {
        return GNRColorComponents(
            r: left * right.r,
            g: left * right.g,
            b: left * right.b,
            alpha: left * right.alpha)
    }
    
    public static func *(left: GNRColorComponents, right: CGFloat) -> GNRColorComponents {
        return right * left
    }
    
    //MARK: Equatable
    public static func ==(left: GNRColorComponents, right: GNRColorComponents) -> Bool {
        return left.r == right.r && left.g == right.g && left.b == right.b && left.alpha == right.alpha
    }
}

public extension UIColor {
    public var gnrcomponents: GNRColorComponents {
        let ciColor = CIColor(color: self)
        return GNRColorComponents(r: 255 * ciColor.red, g: 255 * ciColor.green, b: 255 * ciColor.blue, alpha: ciColor.alpha)
    }
}
