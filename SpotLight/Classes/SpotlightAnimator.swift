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
    
    static func breath(in bounds: CGRect, spot: Spotlight, maxScale: CGFloat, minScale: CGFloat, count: Float, duration: Double, deletate: CAAnimationDelegate) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation()
        animation.duration = duration
        animation.keyPath = "path"
        animation.repeatCount = count
    
        let quarterFrames = Int(duration * 60 * 0.25)
        let rect = spot.frame
        let center = CGPoint(x: rect.origin.x + rect.size.width / 2,
                             y: rect.origin.y + rect.size.height / 2)
        var turnSmallPath = [CGPath]()
        var turnLargePath = [CGPath]()
        let smallScaleDiff = (minScale - 1) / CGFloat(quarterFrames)
        let largeScaleDiff = (maxScale - 1) / CGFloat(quarterFrames)
        for i in 0 ... quarterFrames {
            let fullScreenPath = UIBezierPath(rect: bounds)
            let smallScale = smallScaleDiff * CGFloat(i)
            let smallSize = CGSize(width: rect.size.width * (smallScale + 1),
                                  height: rect.size.height * (smallScale + 1))
            
            let smallRect = CGRect(origin: CGPoint(x: center.x - smallSize.width / 2, y: center.y - smallSize.height / 2), size: smallSize)
            let smallPath = UIBezierPath(roundedRect: smallRect, cornerRadius: spot.cornerRadius)
            fullScreenPath.append(smallPath.reversing())
            turnSmallPath.append(fullScreenPath.cgPath)
            
            fullScreenPath.append(smallPath)
            let largeScale = largeScaleDiff * CGFloat(i)
            let largeSize = CGSize(width: rect.size.width * (largeScale + 1),
                                  height: rect.size.height * (largeScale + 1))
            let largeRect = CGRect(origin: CGPoint(x: center.x - largeSize.width / 2, y: center.y - largeSize.height / 2), size: largeSize)
            let largePath = UIBezierPath(roundedRect: largeRect, cornerRadius: spot.cornerRadius)
            fullScreenPath.append(largePath.reversing())
            turnLargePath.append(fullScreenPath.cgPath)
        }
        
        animation.values = turnSmallPath + turnSmallPath.reversed() + turnLargePath + turnLargePath.reversed()
        animation.delegate = deletate
        return animation
    }
}
