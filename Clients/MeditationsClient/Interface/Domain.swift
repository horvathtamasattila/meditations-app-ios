import Foundation

public struct Meditation: Decodable, Hashable, Equatable {
    public var title: String
    public var subtitle: String
    // swiftlint:disable:next identifier_name
    var audio_files: [Audio]

    public var audioLength: Int? {
        (audio_files.first?.duration ?? 0) / 60
    }
}

public struct Audio: Decodable, Hashable, Equatable {
    var duration: Int
}

public struct ApiError: Error {
    public let message: String?

    public init(error: String?) {
        message = error
    }
}
