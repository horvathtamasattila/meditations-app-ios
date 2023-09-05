import SwiftUI

extension Font {
    enum FontType: String {
        case spaceGrotesk = "SpaceGrotesk-Medium"
    }

    static func font(type: FontType, size: CGFloat) -> Font {
        Font.custom(type.rawValue, size: size)
    }
}
