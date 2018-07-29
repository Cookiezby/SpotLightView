//
//  SpotLight.swift
//  Pods-SpotLight_Example
//
//  Created by cookie on 2018/7/28.
//

import Foundation
import UIKit

final public class SpotlightView: UIView {
    private let spotlightLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    private var spotlights: [Spotlight]
    private var spotlightIndex: Int = 1
    private var completed: (() -> Void)?
    
    public init(frame: CGRect, spotlight: Spotlight, backgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.8), completed: (() -> Void)?) {
        self.spotlights = [spotlight]
        self.completed = completed
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.spotlightLayer.fillColor = backgroundColor.cgColor
        layer.addSublayer(spotlightLayer)
        lightUp(spotlight)
    }
    
    public func addSpotlight(_ spot: Spotlight) {
        spotlights.append(spot)
    }
    
    private func lightUp(_ spot: Spotlight) {
        let fullScreenPath = UIBezierPath(rect: self.frame)
        let path = UIBezierPath(roundedRect: spot.frame, cornerRadius: spot.cornerRadius)
        fullScreenPath.append(path.reversing())
        spotlightLayer.path = fullScreenPath.cgPath
    }
    
    private func lightMove(from: Spotlight, to: Spotlight) {
        let animation = CAKeyframeAnimation()
        animation.duration = to.duration
        animation.isRemovedOnCompletion = false
        animation.keyPath = "path"
        
        let cubic = CubicBezier.cubic(animationCurve: to.animationCurve)
        let frames = Int(to.duration * 60)
        
        let xDif = (to.frame.origin.x - from.frame.origin.x)
        let yDif = (to.frame.origin.y - from.frame.origin.y)
        let wDif = (to.frame.size.width - from.frame.size.width)
        let hDif = (to.frame.size.height - from.frame.size.height)
        
        var paths = [CGPath]()
        for i in 0 ... frames {
            let fullScreenPath = UIBezierPath(rect: bounds)
            let t = CGFloat(i) / CGFloat(frames)
            let progress = cubic.valueY(t: t)
            let rect = CGRect(x: from.frame.origin.x + progress * xDif,
                              y: from.frame.origin.y + progress * yDif,
                          width: from.frame.width + progress * wDif,
                         height: from.frame.height + progress * hDif)
            
            let spotlightPath = UIBezierPath(roundedRect: rect, cornerRadius: to.cornerRadius)
            fullScreenPath.append(spotlightPath.reversing())
            paths.append(fullScreenPath.cgPath)
        }
        
        animation.values = paths
        spotlightLayer.add(animation, forKey: "path")
        spotlightLayer.path = paths.last!
    }
    
    public func nextSpotlight() {
        guard spotlightIndex < spotlights.count else {
            completed?()
            return
        }
        let from = spotlights[spotlightIndex - 1]
        let to   = spotlights[spotlightIndex]
        lightMove(from: from, to: to)
        spotlightIndex += 1
    }
    
    public func autoNext() {
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
