import UIKit

let spaceWidth: CGFloat = 375
let spaceHeight: CGFloat = 668
let baseOffset: CGFloat = spaceWidth

public class SolarSystem: UIView {
    var spaceBodyViews: [SpaceBody]!
    
    public init() {
        super.init(frame: CGRect(x: baseOffset, y: 0, width: SolarSystemBodies.totalWidth, height: spaceHeight))
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.spaceBodyViews = SolarSystemBodies.sorted.map { SpaceBody($0) }
        
        for i in 0..<self.spaceBodyViews.count {
            self.addSubview(self.spaceBodyViews[i])
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToSuperview() {
        self.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: baseOffset).isActive = true
        self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: 0).isActive = true
        self.widthAnchor.constraint(equalToConstant: SolarSystemBodies.totalWidth).isActive = true
        self.heightAnchor.constraint(equalToConstant: spaceHeight).isActive = true
        
        for i in 0..<self.spaceBodyViews.count {
            self.spaceBodyViews[i].adjustConstraints()
        }
    }
    
    func spaceBodyName(forBody body: SolarSystemBodies) -> UILabel {
        let nameLabel = UILabel()
        
        nameLabel.text = body.name
        nameLabel.font = SpaceBody.bodyNameFont
        nameLabel.textColor = .white
        
        return nameLabel
    }
    
    func adjustConstraintForNameLabel(_ label: UILabel, relativeTo body: SpaceBody) {
        label.leadingAnchor.constraint(equalTo: body.trailingAnchor, constant: 8).isActive = true
        label.centerYAnchor.constraint(equalTo: body.centerYAnchor).isActive = true
    }
}
