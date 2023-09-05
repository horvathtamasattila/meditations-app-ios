import Combine
import Foundation
import MeditationsClient

public extension MeditationsClient {
    // Normally I would implement the API client here, and use `.mock` only for development purposes, but since we don't need a real world API request, I'm going to use `.mock` here as well.
    static var live: Self { .mock }
}
