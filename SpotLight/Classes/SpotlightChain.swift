//
//  SpotlightChainView.swift
//  Pods-SpotLight_Example
//
//  Created by cookie on 2018/8/1.
//

import Foundation
import UIKit

final public class SpotlightChain: SpotlightView {
    private var curSpotlight: Spotlight
    
    override public init(frame: CGRect,
                         spotlight: Spotlight,
                         backgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.8),
                         autoNext: Bool = false,
                         completed: (() -> Void)?) {
        self.curSpotlight = spotlight
        super.init(frame: frame, spotlight: spotlight, backgroundColor: backgroundColor, autoNext: autoNext, completed: completed)
    }
    
    public func moveTo(_ to: Spotlight, duration: Double, completed: (() -> Void)? = nil) -> SpotlightChain {
        return moveTo(to, duration: duration, curve: .liner, completed: completed)
    }
    
    public func moveTo(_ to: Spotlight, duration: Double, curve: SpotlightAnimationCurve = .liner, completed: (() -> Void)? = nil) -> SpotlightChain {
        animations.append(SpotlightMove(from: curSpotlight,
                                        to: to,
                                        duration: duration,
                                        animationCurve: curve,
                                        completed: completed))
        curSpotlight = to
        return self
    }
    
    public func scaleTo(_ scale: CGFloat, duratoin: Double, curve: SpotlightAnimationCurve = .liner, completed: (() -> Void)? = nil) -> SpotlightChain {
        let toRect = curSpotlight.frame.insetBy(dx: (1 - scale) * curSpotlight.frame.width / 2,
                                                dy: (1 - scale) * curSpotlight.frame.height / 2)
        let to = Spotlight(frame: toRect, cornerRadius: curSpotlight.cornerRadius * scale)
        animations.append(SpotlightScale(spot: curSpotlight,
                                         scale: scale,
                                         duration: duratoin,
                                         animationCurve: curve,
                                         completed: completed))
        curSpotlight = to
        return self
    }
    
    public func breath(minScale: CGFloat, maxScale: CGFloat, duration: Double, repeatCount: Float, completed: (() -> Void)? = nil) -> SpotlightChain {
        animations.append(SpotlightBreath(spot: curSpotlight,
                                          minScale: minScale,
                                          maxScale: maxScale,
                                          duration: duration,
                                          repeatCount: repeatCount,
                                          completed: completed))
        return self
    }
    
    public func sleep(duration: Double, completed: (() -> Void)? = nil) -> SpotlightChain {
        return breath(minScale: 1, maxScale: 1, duration: duration, repeatCount: 1, completed: completed)
    }


    public func start() {
        popAnimation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
