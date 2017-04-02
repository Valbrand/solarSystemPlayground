import Foundation
import UIKit

public enum ScrollDirection {
    case forward
    case backward
}

public typealias ScrollingCallback = (ScrollDirection) -> ()

public class SpaceViewController: UIViewController, UIScrollViewDelegate {
    var topLevelView: UIView!
    var spaceView: UIScrollView!
    var solarSystemView: SolarSystem!
    var welcomeView: WelcomeView!
    
    var backButton: UIButton!
    var forwardButton: UIButton!
    var currentDistanceLabel: UILabel!
    
    var shouldShowNavigationButtons: Bool = false {
        didSet {
            if self.shouldShowNavigationButtons {
                UIView.animate(withDuration: 0.5, animations: {
                    self.backButton.alpha = 1.0
                    self.forwardButton.alpha = 1.0
                    self.currentDistanceLabel.alpha = 1.0
                })
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.backButton.alpha = 0.0
                    self.forwardButton.alpha = 0.0
                    self.currentDistanceLabel.alpha = 0.0
                })
            }
        }
    }
    
    func scrollingCallback(_ direction: ScrollDirection) {
        if direction == .forward {
            let nextContentOffset = CGPoint(x: self.nextBodyOffset(), y: 0)
            
            self.spaceView.setContentOffset(nextContentOffset, animated: true)
        } else {
            let nextContentOffset = CGPoint(x: self.previousBodyOffset(), y: 0)
            
            self.spaceView.setContentOffset(nextContentOffset, animated: true)
        }
    }
    
    func nextBodyOffset() -> CGFloat {
        let bodies = SolarSystemBodies.sorted
        let currentOffset = self.spaceView.contentOffset.x
        
        if currentOffset >= bodies.last!.offsetForScreenCenter {
            return bodies.last!.offsetForScreenCenter
        } else {
            for body in bodies {
                if body.offsetForScreenCenter - currentOffset > 0.5 {
                    return body.offsetForScreenCenter
                }
            }
        }
        
        return 0.0
    }
    
    func previousBodyOffset() -> CGFloat {
        let bodies = SolarSystemBodies.sorted.reversed()
        let currentOffset = self.spaceView.contentOffset.x
        
        if currentOffset <= bodies.last!.offsetForScreenCenter {
            return 0.0
        } else {
            for body in bodies {
                if currentOffset - body.offsetForScreenCenter > 0.5 {
                    return body.offsetForScreenCenter
                }
            }
        }
        
        return 0.0
    }
    
    override public func loadView() {
        self.topLevelView = UIView(frame: CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight))
        
        self.spaceView = UIScrollView(frame: CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight))
        self.topLevelView.addSubview(self.spaceView)
        
        self.welcomeView = WelcomeView(scrollingCallback: self.scrollingCallback)
        self.welcomeView.translatesAutoresizingMaskIntoConstraints = false
        self.spaceView.addSubview(self.welcomeView)
        
        self.solarSystemView = SolarSystem()
        
        self.spaceView.contentSize = CGSize(width: self.solarSystemView.frame.size.width + baseOffset, height: self.solarSystemView.frame.size.height)
        self.spaceView.addSubview(self.solarSystemView)
        self.spaceView.flashScrollIndicators()
        self.spaceView.backgroundColor = .black
        self.spaceView.delegate = self
        
        self.backButton = UIButton()
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.setTitle("< Go back", for: .normal)
        self.backButton.setTitleColor(.white, for: .normal)
        self.backButton.addTarget(self, action: #selector(SpaceViewController.goBack), for: .touchUpInside)
        self.backButton.alpha = 0.0
        self.topLevelView.addSubview(self.backButton)
        
        self.forwardButton = UIButton()
        self.forwardButton.translatesAutoresizingMaskIntoConstraints = false
        self.forwardButton.setTitle("Go forward >", for: .normal)
        self.forwardButton.setTitleColor(.white, for: .normal)
        self.forwardButton.addTarget(self, action: #selector(SpaceViewController.goForward), for: .touchUpInside)
        self.forwardButton.alpha = 0.0
        self.topLevelView.addSubview(self.forwardButton)
        
        self.currentDistanceLabel = UILabel()
        self.currentDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.currentDistanceLabel.text = ""
        self.currentDistanceLabel.textColor = .white
        self.currentDistanceLabel.alpha = 0.0
        self.currentDistanceLabel.numberOfLines = 0
        self.topLevelView.addSubview(self.currentDistanceLabel)
        
        self.view = self.topLevelView
    }
    
    public override func viewDidLoad() {
        self.setupWelcomeViewConstraints()
        self.setupSolarSystemConstraints()
    }
    
    func goForward() {
        self.scrollingCallback(.forward)
    }
    
    func goBack() {
        self.scrollingCallback(.backward)
    }
    
    func setupWelcomeViewConstraints() {
        self.welcomeView.leadingAnchor.constraint(equalTo: self.spaceView.leadingAnchor).isActive = true
        self.welcomeView.topAnchor.constraint(equalTo: self.spaceView.topAnchor).isActive = true
        self.welcomeView.widthAnchor.constraint(equalTo: self.spaceView.widthAnchor).isActive = true
        self.welcomeView.heightAnchor.constraint(equalTo: self.spaceView.heightAnchor).isActive = true
        
        let marginsGuide = self.view.layoutMarginsGuide
        
        self.backButton.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 4).isActive = true
        self.backButton.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor, constant: -4).isActive = true
        
        self.forwardButton.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor, constant: -4).isActive = true
        self.forwardButton.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor, constant: -4).isActive = true
        
        self.currentDistanceLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 8).isActive = true
        self.currentDistanceLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
        self.currentDistanceLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
    }
    
    func setupSolarSystemConstraints() {
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.x
        
        self.shouldShowNavigationButtons = currentOffset >= spaceWidth
        
        let currentDistance = abs((self.spaceView.contentSize.width - self.spaceView.contentOffset.x - spaceWidth - SolarSystemBodies.sun.diameter / 2) * 2374.0)
        self.currentDistanceLabel.text = "Currently \(currentDistance.sanitizedString()) Km from the sun"
    }
}
