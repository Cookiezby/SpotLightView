//
//  SpotlightAnimation.swift
//  Pods-SpotLight_Example
//
//  Created by cookie on 2018/8/1.
//

import Foundation
import UIKit

public struct Spotlight {
    var frame: CGRect
    var cornerRadius: CGFloat
    
    public init(frame: CGRect, cornerRadius: CGFloat = 0) {
        self.frame = frame
        self.cornerRadius = cornerRadius
    }
}

public enum SpotlightAnimationType: String {
    case move       = "move"
    case breath     = "breath"
}

public protocol SpotlightAnimation {
    var type: SpotlightAnimationType { get }
}


public struct SpotlightMove: SpotlightAnimation {
    public var type = SpotlightAnimationType.move
    public var from: Spotlight
    public var to: Spotlight
    public var duration: Double
    public var animationCurve: SpotlightAnimationCurve
    
    public init(from: Spotlight, to: Spotlight, duration: Double, animationCurve: SpotlightAnimationCurve) {
        self.from = from
        self.to = to
        self.duration = duration
        self.animationCurve = animationCurve
    }
}

public struct SpotlightBreath: SpotlightAnimation {
    public var type = SpotlightAnimationType.breath
    public var spot: Spotlight
    public var minScale: CGFloat
    public var maxScale: CGFloat
    public var duration: Double
    public var repeatCount: Float
    
    public init(spot: Spotlight, minScale: CGFloat, maxScale: CGFloat, duration: Double, repeatCount: Float) {
        self.spot = spot
        self.minScale = min(minScale, 1.0)
        self.maxScale = max(1.0, maxScale)
        self.duration = duration
        self.repeatCount = repeatCount
    }
}
