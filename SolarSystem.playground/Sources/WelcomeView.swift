import Foundation
import UIKit

public class WelcomeView: UIView {
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
    
    override public func didMoveToSuperview() {
        self.setupWelcomeLabelConstraints()
        self.setupStartButtonConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
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
