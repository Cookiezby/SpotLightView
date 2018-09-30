import Foundation


struct CubicBezier {
    var point0 = CGPoint.zero
    var point1: CGPoint
    var point2: CGPoint
    var point3 = CGPoint(x: 1.0, y: 1.0)
    
    init(point1: CGPoint, point2: CGPoint) {
        self.point1 = point1
        self.point2 = point2
    }
    
    func value(t: CGFloat) -> CGPoint {
        assert(t <= 1.0 && t >= 0, "t must between [0, 1]")
        let x =  (1 - t) * (1 - t) * (1 - t) * (point0.x)
            + 3 * (1 - t) * (1 - t) * t * (point1.x)
            + 3 * t * t * (1 - t) * point2.x
            + t * t * t * point3.x
        let y =  (1 - t) * (1 - t) * (1 - t) * (point0.y)
            + 3 * (1 - t) * (1 - t) * t * (point1.y)
            + 3 * t * t * (1 - t) * point2.y
            + t * t * t * point3.y
        return CGPoint(x: x, y: y)
    }
    
    func valueY(t: CGFloat) -> CGFloat {
        return value(t: t).y
    }
}

extension CubicBezier {
    static let liner                = CubicBezier(point1: CGPoint(x: 0.0, y: 0.0), point2: CGPoint(x: 1.0, y: 1.0))
    static let curveEaseIn          = CubicBezier(point1: CGPoint(x: 0.55, y: 0.055), point2: CGPoint(x: 0.675, y: 0.19))
    static let curveEaseOut         = CubicBezier(point1: CGPoint(x: 0.215, y: 0.61), point2: CGPoint(x: 0.355, y: 1.0))
    static let curveEaseInOut       = CubicBezier(point1: CGPoint(x: 0.645, y: 0.045), point2: CGPoint(x: 0.355, y: 1.0))
    
    static func cubic(animationCurve: SpotlightAnimationCurve) -> CubicBezier {
        switch animationCurve {
        case .liner:                return liner
        case .curveEaseIn:          return curveEaseIn
        case .curveEaseOut:         return curveEaseOut
        case .curveEaseInOut:       return curveEaseInOut
        }
    }
}

public enum SpotlightAnimationCurve {
    case liner
    case curveEaseIn
    case curveEaseOut
    case curveEaseInOut
}


