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
    
    private var animations: [SpotlightAnimation]
    private var completed: (() -> Void)?
    
    public init(frame: CGRect,
                spotlight: Spotlight,
                backgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.8),
                autoNext: Bool = false,
                completed: (() -> Void)?) {
        self.animations = []
        self.completed = completed
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.spotlightLayer.fillColor = backgroundColor.cgColor
        layer.addSublayer(spotlightLayer)
        lightUp(spotlight)
    }
    
    public func addSpotlightAnimation(_ animation: SpotlightAnimation) {
        animations.append(animation)
    }
   
    
    private func lightUp(_ spot: Spotlight) {
        let fullScreenPath = UIBezierPath(rect: self.frame)
        let path = UIBezierPath(roundedRect: spot.frame, cornerRadius: spot.cornerRadius)
        fullScreenPath.append(path.reversing())
        spotlightLayer.path = fullScreenPath.cgPath
    }
    

//    public func nextSpotlight() {
//        guard spotlightIndex < spotlights.count else {
//            completed?()
//            return
//        }
//        let from = spotlights[spotlightIndex - 1]
//        let to   = spotlights[spotlightIndex]
//        let move = SpotlightAnimator.move(in: bounds, from: from, to: to, delegate: self)
//        spotlightLayer.add(move.animation, forKey: "move")
//        spotlightLayer.path = move.lastPath
//    }
//
//    public func breath(_ spot: Spotlight) {
//        guard let breath = spot.breath else { return }
//        let breathAnimation = SpotlightAnimator.breath(in: bounds,
//                                                     spot: spot,
//                                                 maxScale: breath.maxScale,
//                                                 minScale: breath.minScale,
//                                                    count: breath.repeatCount,
//                                                 duration: breath.duration,
//                                                 deletate: self)
//        spotlightLayer.add(breathAnimation, forKey: "breath")
//    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SpotlightView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let type = anim.value(forKey: "type") as! SpotlightAnimationType
        switch type {
        case .move:
            break
        case .breath:
            break
        }
    }
}
