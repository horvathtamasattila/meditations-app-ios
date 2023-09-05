import SwiftUI

extension Font {
    enum FontType: String {
        case spaceGrotesk = "SpaceGrotesk-SemiBold"
    }

    static func font(type: FontType, size: CGFloat) -> Font {
        Font.custom(type.rawValue, size: size)
    }
}
