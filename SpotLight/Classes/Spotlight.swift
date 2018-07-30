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
    private var autoNext: Bool
    
    public init(frame: CGRect,
                spotlight: Spotlight,
                backgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.8),
                autoNext: Bool = false,
                completed: (() -> Void)?) {
        
        self.spotlights = [spotlight]
        self.autoNext = autoNext
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
    
    public func nextSpotlight() {
        guard spotlightIndex < spotlights.count else {
            completed?()
            return
        }
        let from = spotlights[spotlightIndex - 1]
        let to   = spotlights[spotlightIndex]
        let move = SpotlightAnimator.move(in: bounds, from: from, to: to, delegate: self)
        spotlightLayer.add(move.animation, forKey: "move")
        spotlightLayer.path = move.lastPath
        spotlightIndex += 1
    }
    
    public func breathTest() {
        let breathAnimation = SpotlightAnimator.breath(in: bounds, spot: spotlights[0], maxScale: 0.95, minScale: 1.15, count: 10, duration: 2.0, deletate: self)
        spotlightLayer.add(breathAnimation, forKey: "breath")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SpotlightView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard autoNext == true else { return }
        nextSpotlight()
    }
}
