import Foundation
import UIKit

public class SpaceBody: UIView {
    let body: SolarSystemBodies
    var nameLabel: UILabel!
    var distanceInKmLabel: UILabel?
    var sizeInKmLabel: UILabel!
    
    static let bodyNameFont = UIFont.boldSystemFont(ofSize: 24)
    static let bodyInfoFont = UIFont.systemFont(ofSize: 12)
    
    public init(_ body: SolarSystemBodies) {
        self.body = body
        
        let renderY: CGFloat = (spaceHeight / 2) - (body.diameter / 2)
        
        super.init(frame: CGRect(x: body.xOffset, y: renderY, width: body.diameter, height: body.diameter))
        
        self.layer.cornerRadius = body.diameter / 2
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
        
        self.nameLabel = UILabel()
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.text = body.name
        self.nameLabel.font = SpaceBody.bodyNameFont
        self.nameLabel.textColor = self.textColor()
        self.addSubview(self.nameLabel)
        
        if body.distanceFromSun > 0 {
            self.distanceInKmLabel = UILabel()
            self.distanceInKmLabel!.translatesAutoresizingMaskIntoConstraints = false
            self.distanceInKmLabel!.text = "\(body.distanceFromSunInKm.sanitizedString()) Km away from the sun"
            self.distanceInKmLabel!.font = SpaceBody.bodyInfoFont
            self.distanceInKmLabel!.textColor = self.textColor()
            self.distanceInKmLabel!.numberOfLines = 0
            self.addSubview(self.distanceInKmLabel!)
        }
        
        self.sizeInKmLabel = UILabel()
        self.sizeInKmLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sizeInKmLabel.text = "\(body.diameterInKm.sanitizedString()) Km wide"
        self.sizeInKmLabel.font = SpaceBody.bodyInfoFont
        self.sizeInKmLabel.textColor = self.textColor()
        self.sizeInKmLabel.numberOfLines = 0
        self.addSubview(self.sizeInKmLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textColor() -> UIColor {
        if self.body == .sun {
            return .black
        } else {
            return .white
        }
    }
    
    public func adjustConstraints() {
        self.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: self.frame.origin.x).isActive = true
        self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: self.frame.origin.y).isActive = true
        self.widthAnchor.constraint(equalToConstant: self.frame.size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.frame.size.height).isActive = true
        
        if let distanceInKmLabel = self.distanceInKmLabel {
            self.nameLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 12).isActive = true
            self.nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            self.distanceInKmLabel?.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor).isActive = true
            self.distanceInKmLabel?.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
            self.distanceInKmLabel?.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
            
            self.sizeInKmLabel.leadingAnchor.constraint(equalTo: distanceInKmLabel.leadingAnchor).isActive = true
            self.sizeInKmLabel.topAnchor.constraint(equalTo: distanceInKmLabel.bottomAnchor).isActive = true
            self.sizeInKmLabel.widthAnchor.constraint(equalToConstant: 160.0).isActive = true
        } else {
            self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            self.sizeInKmLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor).isActive = true
            self.sizeInKmLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        }
    }
}
