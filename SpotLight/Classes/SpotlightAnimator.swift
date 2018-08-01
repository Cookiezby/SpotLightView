//
//  SpotlightAnimator.swift
//  Pods-SpotLight_Example
//
//  Created by cookie on 2018/7/30.
//

import Foundation

typealias SpotlightAnimationPath = (animation: CAKeyframeAnimation, lastPath: CGPath)

class SpotlightAnimator {
    static func move(in bounds: CGRect, move: SpotlightMove, delegate: CAAnimationDelegate) -> SpotlightAnimationPath {
        let animation = CAKeyframeAnimation()
        animation.duration = move.duration
        animation.isRemovedOnCompletion = false
        animation.keyPath = "path"
        
        let cubic = CubicBezier.cubic(animationCurve: move.animationCurve)
        let frames = Int(move.duration * 60)
        
        let xDif = (move.to.frame.origin.x - move.from.frame.origin.x)
        let yDif = (move.to.frame.origin.y - move.from.frame.origin.y)
        let wDif = (move.to.frame.size.width - move.from.frame.size.width)
        let hDif = (move.to.frame.size.height - move.from.frame.size.height)
        
        var paths = [CGPath]()
        for i in 0 ... frames {
            let fullScreenPath = UIBezierPath(rect: bounds)
            let t = CGFloat(i) / CGFloat(frames)
            let progress = cubic.valueY(t: t)
            let rect = CGRect(x: move.from.frame.origin.x + progress * xDif,
                              y: move.from.frame.origin.y + progress * yDif,
                          width: move.from.frame.width    + progress * wDif,
                         height: move.from.frame.height   + progress * hDif)
            
            let spotlightPath = UIBezierPath(roundedRect: rect, cornerRadius: move.to.cornerRadius)
            fullScreenPath.append(spotlightPath.reversing())
            paths.append(fullScreenPath.cgPath)
        }
        animation.values = paths
        animation.delegate = delegate
        animation.setValue(SpotlightAnimationType.move, forKey: "type")
        return (animation, animation.values?.last as! CGPath)
    }
    
//    static func scale(in bounds: CGRect, scale: SpotlightScale, delegate: CAAnimationDelegate) -> SpotlightAnimationPath {
//        
//    }
    
    static func breath(in bounds: CGRect, breath: SpotlightBreath, deletate: CAAnimationDelegate) -> SpotlightAnimationPath {
        let animation = CAKeyframeAnimation()
        animation.duration = breath.duration
        animation.keyPath = "path"
        animation.repeatCount = breath.repeatCount
        animation.isRemovedOnCompletion = false
    
        let quarterFrames = Int(breath.duration * 60 * 0.25)
        let rect = breath.spot.frame
        let center = CGPoint(x: rect.origin.x + rect.size.width / 2,
                             y: rect.origin.y + rect.size.height / 2)
        var turnSmallPath = [CGPath]()
        var turnLargePath = [CGPath]()
        let smallScaleDiff = (breath.minScale - 1) / CGFloat(quarterFrames)
        let largeScaleDiff = (breath.maxScale - 1) / CGFloat(quarterFrames)
        for i in 0 ... quarterFrames {
            let fullScreenPath = UIBezierPath(rect: bounds)
            let smallScale = smallScaleDiff * CGFloat(i)
            let smallSize = CGSize(width: rect.size.width * (smallScale + 1),
                                  height: rect.size.height * (smallScale + 1))
            
            let smallRect = CGRect(origin: CGPoint(x: center.x - smallSize.width / 2, y: center.y - smallSize.height / 2), size: smallSize)
            let smallPath = UIBezierPath(roundedRect: smallRect, cornerRadius: breath.spot.cornerRadius)
            fullScreenPath.append(smallPath.reversing())
            turnSmallPath.append(fullScreenPath.cgPath)
            
            fullScreenPath.append(smallPath)
            let largeScale = largeScaleDiff * CGFloat(i)
            let largeSize = CGSize(width: rect.size.width * (largeScale + 1),
                                  height: rect.size.height * (largeScale + 1))
            let largeRect = CGRect(origin: CGPoint(x: center.x - largeSize.width / 2, y: center.y - largeSize.height / 2), size: largeSize)
            let largePath = UIBezierPath(roundedRect: largeRect, cornerRadius: breath.spot.cornerRadius)
            fullScreenPath.append(largePath.reversing())
            turnLargePath.append(fullScreenPath.cgPath)
        }
        
        animation.values = turnSmallPath + turnSmallPath.reversed() + turnLargePath + turnLargePath.reversed()
        animation.delegate = deletate
        animation.setValue(SpotlightAnimationType.breath, forKey: "type")
        return (animation, animation.values?.last as! CGPath)
    }
}
