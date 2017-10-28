//
//  GNRDynamicNavigationBar.swift
//  GNRDynamicNavigationBar
//
//  Created by Gustavo Sgarbi Campos on 28/5/17.
//  Copyright © 2017 Gustavo Sgarbi Campos. All rights reserved.
//

import Foundation
import SnapKit

public class GNRDynamicNavigationBar: UIView, UIScrollViewDelegate {
    //MARK: UIElements
    public let leftBarButton = UIButton()
    public let rightBarButton = UIButton()
    public var targetView: UIView?
    
    //MARK: Instance properties
    var tintStartComponents = GNRColorComponents(r: 255, g: 255, b: 255, alpha: 1)
    public var tintStartColor: UIColor {
        get {
            return self.tintStartComponents.color
        }
        set {
            self.tintStartComponents = newValue.gnrcomponents
        }
    }
    
    var tintEndComponents = GNRColorComponents(r: 0, g: 0, b: 0, alpha: 1)
    public var tintEndColor: UIColor {
        get {
            return self.tintEndComponents.color
        }
        set {
            self.tintEndComponents = newValue.gnrcomponents
        }
    }
    
    var bkgStartComponents = GNRColorComponents(r: 255, g: 255, b: 255, alpha: 0)
    public var bkgStartColor: UIColor {
        get {
            return self.bkgStartComponents.color
        }
        set {
            self.bkgStartComponents = newValue.gnrcomponents
        }
    }
    
    var bkgEndComponents = GNRColorComponents(r: 255, g: 255, b: 255, alpha: 1)
    public var bkgEndColor: UIColor {
        get {
            return self.bkgEndComponents.color
        }
        set {
            self.bkgEndComponents = newValue.gnrcomponents
        }
    }
    
    /**
     Between 0 and 1
     **/
    public var stage: CGFloat = -1 {
        didSet {
            if(oldValue != self.stage && self.stage >= 0 && self.stage <= 1) {
                self.backgroundColor = ((stage * self.bkgEndComponents) + ((1 - stage) * self.bkgStartComponents)).color
                let tintColor = ((stage * self.tintEndComponents) + ((1 - stage) * self.tintStartComponents)).color
                self.leftBarButton.tintColor = tintColor
                self.rightBarButton.tintColor = tintColor
            }
        }
    }
    
    //MARK: Init
    public override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
    }
    
    public func customInit() {
        self.addSubview(self.leftBarButton)
        let btnSize = CGSize(width: 40, height: 30)
        let btnMargin = 8
        self.leftBarButton.contentHorizontalAlignment = .left
        self.leftBarButton.setImage(UIImage(named: "back_arrow", in: Bundle(for: type(of: self)), compatibleWith: nil)!.withRenderingMode(.alwaysTemplate), for: .normal)
        self.leftBarButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(btnMargin)
            make.centerY.equalTo(self)
            make.size.equalTo(btnSize)
        }
        self.addSubview(self.rightBarButton)
        self.rightBarButton.contentHorizontalAlignment = .center
        self.rightBarButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-btnMargin)
            make.centerY.equalTo(self)
            make.size.equalTo(btnSize)
        }
        self.stage = 0
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 64 - UIApplication.shared.statusBarFrame.height)
    }
    
    //MARK: Helper
    public func attach(to: UIScrollView) {
        guard let view = to.superview else {
            print("GNRDynamicNavigationBar error attaching navigation bar: ScrollView must have a superview")
            return
        }
        view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.top.equalTo(to)
            make.left.equalTo(to)
            make.right.equalTo(to)
        }
    }
    
    //MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let targetView = self.targetView, targetView.isDescendant(of: scrollView) else {
            return
        }
        let convertedRect = targetView.convert(targetView.frame, to: scrollView)
        if(scrollView.contentOffset.y > convertedRect.minY && scrollView.contentOffset.y < convertedRect.maxY) {
            self.stage = (scrollView.contentOffset.y - convertedRect.minY)/(convertedRect.height - self.intrinsicContentSize.height)
        }
    }
}
