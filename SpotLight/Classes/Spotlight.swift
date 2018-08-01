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
        spotlightLayer.fillColor = backgroundColor.cgColor
        layer.addSublayer(spotlightLayer)
        lightUp(spotlight)
    }
    
    public func pushAnimation(_ animation: SpotlightAnimation) {
        animations.append(animation)
    }
   
    public func popAnimation() {
        guard animations.count > 0 else { return }
        let animation = animations.remove(at: 0)
        switch animation.type {
        case .move:
            performMove(animation: animation as! SpotlightMove)
        case .breath:
            performBreath(animation: animation as! SpotlightBreath)
        }
    }
    
    private func lightUp(_ spot: Spotlight) {
        let fullScreenPath = UIBezierPath(rect: self.frame)
        let path = UIBezierPath(roundedRect: spot.frame, cornerRadius: spot.cornerRadius)
        fullScreenPath.append(path.reversing())
        spotlightLayer.path = fullScreenPath.cgPath
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SpotlightView {
    func performMove(animation: SpotlightMove) {
        let result = SpotlightAnimator.move(in: bounds, move: animation, delegate: self)
        spotlightLayer.add(result.animation, forKey: animation.type.rawValue)
        spotlightLayer.path = result.lastPath
    }
    
    func performBreath(animation: SpotlightBreath) {
        let result = SpotlightAnimator.breath(in: bounds, breath: animation, deletate: self)
        spotlightLayer.add(result.animation, forKey: animation.type.rawValue)
        spotlightLayer.path = result.lastPath
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
