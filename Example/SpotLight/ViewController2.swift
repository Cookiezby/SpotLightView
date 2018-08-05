//
//  ViewController2.swift
//  SpotLight_Example
//
//  Created by cookie on 2018/8/4.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class ViewController2: UIViewController {
    
    let shapeLayer = CAShapeLayer()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.layer.addSublayer(shapeLayer)
        shapeLayer.fillColor = UIColor.black.cgColor
        let fullPath = UIBezierPath(rect: view.bounds)
        
        let fullPath2 = CGMutablePath()
        fullPath2.addPath(CGPath(rect: view.bounds, transform: nil))
        //let tempPath = UIBezierPath(roundedRect: CGRect(x: 100, y: 100, width: 100, height: 100), cornerRadius: 32.8)
        
        let tempPath2 = CGMutablePath()
        tempPath2.addPath(CGPath(roundedRect: CGRect(x: 100, y: 100, width: 100, height: 100), cornerWidth: 34, cornerHeight: 34, transform: nil))
        
        fullPath.append(UIBezierPath(cgPath: tempPath2))
        fullPath.usesEvenOddFillRule = true
        
    
        shapeLayer.path = fullPath.cgPath
        shapeLayer.fillRule = kCAFillRuleEvenOdd
    }
    
    
}
