import UIKit

let spaceWidth: CGFloat = 375
let spaceHeight: CGFloat = 668

enum ScrollDirection {
    case forward
    case backward
}

typealias ScrollingCallback = (ScrollDirection) -> ()

public class SpaceViewController: UIViewController {
    var welcomeView: WelcomeView!
    var scrollingCallback: ScrollingCallback = {
        direction in
        
        print("\(direction)")
    }
    
    override public func loadView() {
        let spaceView = UIScrollView(frame: CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight))
        
        self.welcomeView = WelcomeView(scrollingCallback: self.scrollingCallback)
        self.welcomeView.translatesAutoresizingMaskIntoConstraints = false
        spaceView.addSubview(self.welcomeView)
        
        let solarSystemView = SolarSystem(xOffset: spaceWidth * 2)
        spaceView.contentSize = CGSize(width: solarSystemView.frame.size.width + spaceWidth * 2, height: solarSystemView.frame.size.height)
        spaceView.addSubview(solarSystemView)
        spaceView.flashScrollIndicators()
        spaceView.backgroundColor = .black
        
        self.view = spaceView
    }
    
    public override func viewDidLoad() {
        self.welcomeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.welcomeView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.welcomeView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.welcomeView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
}

class WelcomeView: UIView {
    var welcomeLabel: UILabel!
    var startButton: UIButton!
    
    var scrollingCallback: ScrollingCallback
    
    public init(scrollingCallback: @escaping ScrollingCallback) {
        self.scrollingCallback = scrollingCallback
        
        super.init(frame: CGRect.zero)
        
        self.welcomeLabel = UILabel()
        self.setupWelcomeLabel()
        self.addSubview(self.welcomeLabel)
        
        self.startButton = UIButton()
        self.setupStartButton()
        self.addSubview(self.startButton)
    }
    
    override func didMoveToSuperview() {
        self.setupWelcomeLabelConstraints()
        self.setupStartButtonConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWelcomeLabel() {
        self.welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.welcomeLabel.text = "What if Pluto was 1 pixel wide?"
        self.welcomeLabel.textColor = .white
        self.welcomeLabel.font = UIFont.boldSystemFont(ofSize: 44)
        self.welcomeLabel.numberOfLines = 0
    }
    
    func setupWelcomeLabelConstraints() {
        let marginsGuide = self.layoutMarginsGuide
        
        self.welcomeLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 8).isActive = true
        self.welcomeLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor, constant: 8).isActive = true
        self.welcomeLabel.bottomAnchor.constraint(equalTo: marginsGuide.centerYAnchor, constant: -16).isActive = true
    }
    
    func setupStartButton() {
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        self.startButton.setTitle("Find out >", for: .normal)
        self.startButton.setTitleColor(.white, for: .normal)
        self.startButton.addTarget(self, action: #selector(WelcomeView.startButtonAction), for: .touchUpInside)
    }
    
    func setupStartButtonConstraints() {
        let marginsGuide = self.layoutMarginsGuide
        
        self.startButton.centerXAnchor.constraint(equalTo: marginsGuide.centerXAnchor).isActive = true
        self.startButton.topAnchor.constraint(equalTo: marginsGuide.centerYAnchor, constant: 16).isActive = true
    }
    
    func startButtonAction() {
        self.scrollingCallback(.forward)
    }
}

class SolarSystem: UIView {
    public init(xOffset: CGFloat) {
        super.init(frame: CGRect(x: xOffset, y: 0, width: SolarSystemBodies.totalWidth, height: spaceHeight))
    }
    
    override func didMoveToSuperview() {
        let allBodies = SolarSystemBodies.sorted
        var diameterSum: CGFloat = 0
        
        for (index, body) in allBodies.enumerated() {
            let bodyX = CGFloat((index + 1) * 10) + diameterSum
            
            let bodyView = SpaceBody(x: bodyX, diameter: body.diameter)
            self.addSubview(bodyView)
            
            diameterSum += body.diameter
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SpaceBody: UIView {
    init(x: CGFloat, diameter: CGFloat) {
        let renderY: CGFloat = (spaceHeight / 2) - (diameter / 2)
        
        super.init(frame: CGRect(x: x, y: renderY, width: diameter, height: diameter))
        
        self.layer.cornerRadius = diameter / 2
        self.backgroundColor = .red
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
    
    static var sorted: [SolarSystemBodies] {
        return [.sun, .mercury, .venus, .earth, .moon, .mars, .jupiter, .saturn, .uranus, .neptune, .pluto]
    }
    
    static var totalWidth: CGFloat {
        return 10.0 + SolarSystemBodies.sorted.reduce(0.0) {
            partial, body in
            
            return partial + body.diameter + 10
        }
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
