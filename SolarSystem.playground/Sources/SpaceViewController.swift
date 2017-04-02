import Foundation
import UIKit

public enum ScrollDirection {
    case forward
    case backward
}

public typealias ScrollingCallback = (ScrollDirection) -> ()

public class SpaceViewController: UIViewController {
    var spaceView: UIScrollView!
    var welcomeView: WelcomeView!
    
    func scrollingCallback(_ direction: ScrollDirection) {
        if direction == .forward {
            let nextContentOffset = CGPoint(x: self.nextBodyOffset(), y: 0)
            
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
                if currentOffset < body.offsetForScreenCenter {
                    return body.offsetForScreenCenter
                }
            }
        }
        
        return 0.0
    }
    
    override public func loadView() {
        self.spaceView = UIScrollView(frame: CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight))
        
        self.welcomeView = WelcomeView(scrollingCallback: self.scrollingCallback)
        self.welcomeView.translatesAutoresizingMaskIntoConstraints = false
        self.spaceView.addSubview(self.welcomeView)
        
        let solarSystemView = SolarSystem()
        self.spaceView.contentSize = CGSize(width: solarSystemView.frame.size.width + baseOffset, height: solarSystemView.frame.size.height)
        self.spaceView.addSubview(solarSystemView)
        self.spaceView.flashScrollIndicators()
        self.spaceView.backgroundColor = .black
        
        self.view = spaceView
    }
    
    public override func viewDidLoad() {
        self.welcomeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.welcomeView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.welcomeView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.welcomeView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
}
