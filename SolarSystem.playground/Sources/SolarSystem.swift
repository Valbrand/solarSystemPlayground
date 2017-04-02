import UIKit

let spaceWidth: CGFloat = 375
let spaceHeight: CGFloat = 668
let baseOffset: CGFloat = spaceWidth

public class SolarSystem: UIView {
    public init() {
        super.init(frame: CGRect(x: baseOffset, y: 0, width: SolarSystemBodies.totalWidth, height: spaceHeight))
    }
    
    override public func didMoveToSuperview() {
        for body in SolarSystemBodies.sorted {
            let bodyView = SpaceBody(body)
            self.addSubview(bodyView)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SpaceBody: UIView {
    init(_ body: SolarSystemBodies) {
        let renderY: CGFloat = (spaceHeight / 2) - (body.diameter / 2)
        
        super.init(frame: CGRect(x: body.xOffset, y: renderY, width: body.diameter, height: body.diameter))
        
        self.layer.cornerRadius = body.diameter / 2
        self.backgroundColor = .white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum SolarSystemBodies {
    case sun
    case mercury
    case venus
    case earth
    case moon
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    case pluto
    
    static public var sorted: [SolarSystemBodies] {
        return [.sun, .mercury, .venus, .earth, .moon, .mars, .jupiter, .saturn, .uranus, .neptune, .pluto]
    }
    
    static public var totalWidth: CGFloat {
        let lastBody = SolarSystemBodies.sorted.last!
        
        return lastBody.offsetForScreenCenter + spaceWidth / 2
    }
    
    public var distanceFromSun: CGFloat {
        switch self {
        case .sun:
            return 0.0
        case .mercury:
            return 24782.6086956522
        case .venus:
            return 46956.5217391304
        case .earth:
            return 65217.3913043478
        case .moon:
            return 65384.5217391304
        case .mars:
            return 99130.4347826087
        case .jupiter:
            return 338695.652173913
        case .saturn:
            return 621739.130434783
        case .uranus:
            return 1252173.91304348
        case .neptune:
            return 1956521.73913043
        case .pluto:
            return 2565217.39130435
        }
    }
    
    public var diameter: CGFloat {
        switch self {
        case .sun:
            return 605.217391304348
        case .mercury:
            return 2.12130434782609
        case .venus:
            return 5.26260869565217
        case .earth:
            return 5.54608695652174
        case .moon:
            return 1.51086956521739
        case .mars:
            return 2.95391304347826
        case .jupiter:
            return 62.1652173913043
        case .saturn:
            return 52.4086956521739
        case .uranus:
            return 22.2260869565217
        case .neptune:
            return 21.5347826086957
        case .pluto:
            return 1
        }
    }
    
    public var xOffset: CGFloat {
        return self.distanceFromSun + (SolarSystemBodies.sun.diameter / 2) - (self.diameter / 2)
    }
    
    public var offsetForScreenCenter: CGFloat {
        return self.xOffset + (self.diameter / 2) - (spaceWidth / 2) + baseOffset
    }
}
