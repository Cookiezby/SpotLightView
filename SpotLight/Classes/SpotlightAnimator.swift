//
//  SpotlightAnimator.swift
//  Pods-SpotLight_Example
//
//  Created by cookie on 2018/7/30.
//

import Foundation

class SpotlightAnimator {
    typealias SpotlightMove = (animation: CAKeyframeAnimation, lastPath: CGPath)
    static func move(in bounds: CGRect, from: Spotlight, to: Spotlight, delegate: CAAnimationDelegate) -> SpotlightMove {
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
                          width: from.frame.width    + progress * wDif,
                         height: from.frame.height   + progress * hDif)
            
            let spotlightPath = UIBezierPath(roundedRect: rect, cornerRadius: to.cornerRadius)
            fullScreenPath.append(spotlightPath.reversing())
            paths.append(fullScreenPath.cgPath)
        }
        animation.values = paths
        animation.delegate = delegate
        return (animation, animation.values?.last as! CGPath)
    }
    
    static func breath(maxScale: CGFloat, minScale: CGFloat, count: Float, duration: Double, deletate: CAAnimationDelegate) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation()
        animation.duration = duration
        animation.keyPath = "transform"
        animation.repeatCount = count
    
        let frames = Int(duration * 60)
        var path = [CGPath]()
        for i in 0 ... frames {
            
            
            
        }
        
        let identity = CATransform3DIdentity
        let minScale = CATransform3DTranslate(identity, minScale, minScale, 1.0)
        let maxScale = CATransform3DTranslate(identity, maxScale, maxScale, 1.0)
        animation.values = [identity, minScale, identity, maxScale, identity]
        animation.delegate = deletate
        return animation
    }
}
