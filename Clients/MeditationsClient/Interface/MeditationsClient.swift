import Combine
import CoreLocation

public struct MeditationsClient {
    public var getMeditations: (CLLocationCoordinate2D?) -> any Publisher<[Meditation], ApiError>

    public init(getMeditations: @escaping (CLLocationCoordinate2D?) -> any Publisher<[Meditation], ApiError>) {
        self.getMeditations = getMeditations
    }
}
