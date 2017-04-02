import Foundation
import UIKit

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
        return [.pluto, .neptune, .uranus, .saturn, .jupiter, .mars, .moon, .earth, .venus, .mercury, .sun]
    }
    
    static public var totalWidth: CGFloat {
        return SolarSystemBodies.pluto.distanceFromSun + spaceWidth + (SolarSystemBodies.sun.diameter / 2)
    }
    
    public var distanceFromSun: CGFloat {
        switch self {
        case .sun:
            return 0.0
        case .mercury:
            return 24010.109519797809604
        case .venus:
            return 45492.839090143218197
        case .earth:
            return 63184.498736310025274
        case .moon:
            return 63346.251053074978939
        case .mars:
            return 96040.438079191238416
        case .jupiter:
            return 328138.163437236731255
        case .saturn:
            return 602358.887952822240944
        case .uranus:
            return 1213142.375737152485257
        case .neptune:
            return 1895534.962089300758214
        case .pluto:
            return 2489469.250210614995788
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
    
    public var name: String {
        switch self {
        case .sun:
            return "Sun"
        case .mercury:
            return "Mercury"
        case .venus:
            return "Venus"
        case .earth:
            return "Earth"
        case .moon:
            return "Moon"
        case .mars:
            return "Mars"
        case .jupiter:
            return "Jupiter"
        case .saturn:
            return "Saturn"
        case .uranus:
            return "Uranus"
        case .neptune:
            return "Neptune"
        case .pluto:
            return "Pluto"
        }
    }
    
    public var distanceFromSunInKm: CGFloat {
        return self.distanceFromSun * 2374.0
    }
    
    public var diameterInKm: CGFloat {
        return self.diameter * 2374.0
    }
    
    public var xOffset: CGFloat {
        return SolarSystemBodies.pluto.distanceFromSun - self.distanceFromSun - (self.diameter / 2) + (spaceWidth / 2)
    }
    
    public var offsetForScreenCenter: CGFloat {
        return self.xOffset + (self.diameter / 2) - (spaceWidth / 2) + baseOffset
    }
}
