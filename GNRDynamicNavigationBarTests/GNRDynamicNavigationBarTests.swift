//
//  GNRDynamicNavigationBarTests.swift
//  GNRDynamicNavigationBarTests
//
//  Created by Gustavo Sgarbi Campos on 10/28/17.
//  Copyright © 2017 Gustavo Sgarbi Campos. All rights reserved.
//

import XCTest
@testable import GNRDynamicNavigationBar

class GNRDynamicNavigationBarTests: XCTestCase {
    let red: CGFloat = 0
    let green: CGFloat = 255/2
    let blue: CGFloat = 255
    let alpha: CGFloat = 1
    var navBar: GNRDynamicNavigationBar! = GNRDynamicNavigationBar()
    
    override func tearDown() {
        self.navBar = nil
        super.tearDown()
    }
    
    func testColorInit() {
        let components = GNRColorComponents(r: -200, g: 300, b: 100, alpha: 2)
        XCTAssert(components.r == 0)
        XCTAssert(components.g == 255)
        XCTAssert(components.b == 100)
        XCTAssert(components.alpha == 1)
        let components2 = GNRColorComponents(r: -200, g: 300, b: 100, alpha: -2)
        XCTAssert(components2.alpha == 0)
        let components3 = GNRColorComponents(r: -200, g: 300, b: 100, alpha: 0.5)
        XCTAssert(components3.alpha == 0.5)
    }
    
    func testSumColors() {
        let components = GNRColorComponents(r: 50, g: 100, b: 250, alpha: 0.3)
        let components2 = GNRColorComponents(r: 50, g: 100, b: 250, alpha: 0.3)
        let sum = components + components2
        XCTAssert(sum.r == 100)
        XCTAssert(sum.g == 200)
        XCTAssert(sum.b == 255)
        XCTAssert(sum.alpha == 0.6)
        let components3 = GNRColorComponents(r: 50, g: 100, b: 250, alpha: 0.8)
        let sum2 = components + components3
        XCTAssert(sum2.alpha == 1)
    }
    
    func testMultiplyColors() {
        let components = GNRColorComponents(r: 50, g: 100, b: 200, alpha: 0.3)
        let components1 = 1 * components
        XCTAssert(components == components1)
        let components2 = components * 1
        XCTAssert(components == components2)
        let components3 = 2 * components
        XCTAssert(components3.r == 100)
        XCTAssert(components3.g == 200)
        XCTAssert(components3.b == 255)
        XCTAssert(components3.alpha == 0.6)
        let components4 = 3 * components
        XCTAssert(components4.r == 150)
        XCTAssert(components4.g == 255)
        XCTAssert(components4.b == 255)
        XCTAssert(components4.alpha < 1) //0.89~ != 0.9
        let components5 = 4 * components
        XCTAssert(components5.r == 200)
        XCTAssert(components5.g == 255)
        XCTAssert(components5.b == 255)
        XCTAssert(components5.alpha == 1)
        let components6 = 6 * components
        XCTAssert(components6.r == 255)
        XCTAssert(components6.g == 255)
        XCTAssert(components6.b == 255)
        XCTAssert(components6.alpha == 1)
        let components7 = 0 * components
        XCTAssert(components7.r == 0)
        XCTAssert(components7.g == 0)
        XCTAssert(components7.b == 0)
        XCTAssert(components7.alpha == 0)
        let components8 = -1 * components
        XCTAssert(components8.r == 0)
        XCTAssert(components8.g == 0)
        XCTAssert(components8.b == 0)
        XCTAssert(components8.alpha == 0)
    }
    
    func testColorConversion() {
        XCTAssert(UIColor.white.gnrcomponents == GNRColorComponents(r: 255, g: 255, b: 255, alpha: 1))
        let components = GNRColorComponents(r: self.red, g: self.green, b: self.blue, alpha: self.alpha)
        XCTAssert(components == components.color.gnrcomponents)
        XCTAssert(components == components)
        let invertedComponents = GNRColorComponents(r: 255 - self.red, g: 255 - self.green, b: 255 - self.blue, alpha: 1 - self.alpha)
        XCTAssert(invertedComponents == components.inverse)
        XCTAssert(invertedComponents != components)
        let invertedRGBComponents = GNRColorComponents(r: 255 - self.red, g: 255 - self.green, b: 255 - self.blue, alpha: self.alpha)
        XCTAssert(invertedRGBComponents == components.rgbInverse)
        XCTAssert(invertedRGBComponents != components)
        XCTAssert(invertedComponents != invertedRGBComponents)
    }
    
}
