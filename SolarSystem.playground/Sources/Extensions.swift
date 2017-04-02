import Foundation
import UIKit

fileprivate let million: CGFloat = 1000000
fileprivate let billion: CGFloat = 1000000000

extension CGFloat {
    func sanitizedString() -> String {
        if (self > billion) {
            return String.localizedStringWithFormat("%.1f billion", self / billion)
        } else if (self > million) {
            return String.localizedStringWithFormat("%.1f million", self / million)
        } else {
            return String.localizedStringWithFormat("%.1f", self)
        }
    }
}
