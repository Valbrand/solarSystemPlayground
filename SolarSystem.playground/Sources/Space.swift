import UIKit

let spaceWidth: CGFloat = 1000
let spaceHeight: CGFloat = 700

public class Space: UIView {
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight))
        
        self.backgroundColor = .black
        
        let sun = SolarSystemBodies.sun
        self.addSubview(SpaceBody(x: 0, diameter: sun.diameter))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SpaceBody: UIView {
    init(x: CGFloat, diameter: CGFloat) {
        let renderY: CGFloat = (spaceHeight / 2) - (diameter / 2)
        
        super.init(frame: CGRect(x: x, y: renderY, width: diameter, height: diameter))
        
        self.layer.cornerRadius = diameter / 2
        self.backgroundColor = .white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum SolarSystemBodies {
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
    
    var sorted: [SolarSystemBodies] {
        return [.sun, .mercury, .venus, .earth, .moon, .mars, .jupiter, .saturn, .uranus, .neptune, .pluto]
    }
    
    var distanceFromSun: CGFloat {
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
    
    var diameter: CGFloat {
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
}
