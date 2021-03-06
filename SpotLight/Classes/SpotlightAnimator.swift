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
        let cornerRadiusDiff = (move.to.cornerRadius - move.from.cornerRadius)
        var paths = [CGPath]()
        for i in 0 ... frames {
            let fullScreenPath = UIBezierPath(rect: bounds)
            fullScreenPath.usesEvenOddFillRule = true
            let t = CGFloat(i) / CGFloat(frames)
            let progress = cubic.valueY(t: t)
            let rect = CGRect(x: move.from.frame.origin.x + progress * xDif,
                              y: move.from.frame.origin.y + progress * yDif,
                          width: move.from.frame.width    + progress * wDif,
                         height: move.from.frame.height   + progress * hDif)
            let spotlightPath = CGMutablePath()
            let cornerRadius = move.from.cornerRadius + cornerRadiusDiff * progress
            spotlightPath.addPath(CGPath(roundedRect: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil))
            fullScreenPath.append(UIBezierPath(cgPath: spotlightPath))
            paths.append(fullScreenPath.cgPath)
        }
        animation.values = paths
        animation.delegate = delegate
        animation.setValue(SpotlightAnimationType.move, forKey: "type")
        return (animation, paths.last!)
    }
    
    static func scale(in bounds: CGRect, scale: SpotlightScale, delegate: CAAnimationDelegate) -> SpotlightAnimationPath {
        let animation = CAKeyframeAnimation()
        animation.duration = scale.duration
        animation.keyPath = "path"
        animation.isRemovedOnCompletion = false
        
        let frames = Int(scale.duration * 60)
        var paths = [CGPath]()
        let scaleDiff = (scale.scale - 1) / CGFloat(frames)
        for i in 0 ... frames {
            let fullScreenPath = UIBezierPath(rect: bounds)
            fullScreenPath.usesEvenOddFillRule = true
            let s =  CGFloat(i) * scaleDiff
            let cornerRadius = scale.spot.cornerRadius * (s + 1)
            let rect = scale.spot.frame.insetBy(dx: -s * scale.spot.frame.width / 2, dy: -s * scale.spot.frame.height / 2)
            let spotlightPath = CGMutablePath()
            spotlightPath.addPath(CGPath(roundedRect: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil))
            fullScreenPath.append(UIBezierPath(cgPath: spotlightPath))
            paths.append(fullScreenPath.cgPath)
        }
        
        animation.values = paths
        animation.delegate = delegate
        animation.setValue(SpotlightAnimationType.scale, forKey: "type")
        return (animation, paths.last!)
    }
    
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
            var fullScreenPath = UIBezierPath(rect: bounds)
            fullScreenPath.usesEvenOddFillRule = true
            let smallScale = smallScaleDiff * CGFloat(i)
            let smallSize = CGSize(width: rect.size.width * (smallScale + 1),
                                  height: rect.size.height * (smallScale + 1))
            
            let smallCornerRadius = (smallScale + 1) * breath.spot.cornerRadius
            let smallRect = CGRect(origin: CGPoint(x: center.x - smallSize.width / 2, y: center.y - smallSize.height / 2), size: smallSize)
            let smallPath = CGMutablePath()
            smallPath.addPath(CGPath(roundedRect: smallRect, cornerWidth: smallCornerRadius, cornerHeight: smallCornerRadius, transform: nil))
            fullScreenPath.append(UIBezierPath(cgPath: smallPath))
            turnSmallPath.append(fullScreenPath.cgPath)
            
            
            fullScreenPath = UIBezierPath(rect: bounds)
            let largeScale = largeScaleDiff * CGFloat(i)
            let largeSize = CGSize(width: rect.size.width * (largeScale + 1),
                                  height: rect.size.height * (largeScale + 1))
            let largeCornerRaduis = (largeScale + 1) * breath.spot.cornerRadius
            let largeRect = CGRect(origin: CGPoint(x: center.x - largeSize.width / 2, y: center.y - largeSize.height / 2), size: largeSize)
            let largePath = CGMutablePath()
            largePath.addPath(CGPath(roundedRect: largeRect, cornerWidth: largeCornerRaduis, cornerHeight: largeCornerRaduis, transform: nil))
            fullScreenPath.append(UIBezierPath(cgPath: largePath))
            turnLargePath.append(fullScreenPath.cgPath)
        }
        
        animation.values = turnSmallPath + turnSmallPath.reversed() + turnLargePath + turnLargePath.reversed()
        animation.delegate = deletate
        animation.setValue(SpotlightAnimationType.breath, forKey: "type")
        return (animation, animation.values?.last as! CGPath)
    }
}
