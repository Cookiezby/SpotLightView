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
        self.cornerRadius = min(frame.height * 0.32, cornerRadius)
    }
}

public enum SpotlightAnimationType: String {
    case move       = "move"
    case scale      = "scale"
    case breath     = "breath"
}

public protocol SpotlightAnimation {
    var type: SpotlightAnimationType    { get }
    var completed: (() -> Void)?        { get }
}


public struct SpotlightMove: SpotlightAnimation {
    public var type = SpotlightAnimationType.move
    public var from: Spotlight
    public var to: Spotlight
    public var duration: Double
    public var animationCurve: SpotlightAnimationCurve
    public var completed: (() -> Void)?
    
    public init(from: Spotlight, to: Spotlight, duration: Double, animationCurve: SpotlightAnimationCurve, completed: (() -> Void)? = nil) {
        self.from = from
        self.to = to
        self.duration = duration
        self.animationCurve = animationCurve
        self.completed = completed
    }
}

public struct SpotlightScale: SpotlightAnimation {
    public var type = SpotlightAnimationType.scale
    public var spot: Spotlight
    public var scale: CGFloat
    public var duration: Double
    public var animationCurve: SpotlightAnimationCurve
    public var completed: (() -> Void)?
    
    public init(spot: Spotlight, scale: CGFloat, duration: Double, animationCurve: SpotlightAnimationCurve, completed: (() -> Void)?) {
        self.spot = spot
        self.scale = scale
        self.duration = duration
        self.animationCurve = animationCurve
        self.completed = completed
    }
}

public struct SpotlightBreath: SpotlightAnimation {
    public var type = SpotlightAnimationType.breath
    public var spot: Spotlight
    public var minScale: CGFloat
    public var maxScale: CGFloat
    public var duration: Double
    public var repeatCount: Float
    public var completed: (() -> Void)?
    
    public init(spot: Spotlight, minScale: CGFloat, maxScale: CGFloat, duration: Double, repeatCount: Float, completed: (() -> Void)? = nil) {
        self.spot = spot
        self.minScale = min(minScale, 1.0)
        self.maxScale = max(1.0, maxScale)
        self.duration = duration
        self.repeatCount = repeatCount
        self.completed = completed
    }
}
