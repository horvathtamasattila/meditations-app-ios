import CoreLocation

public class LocationProvider: NSObject, CLLocationManagerDelegate {
    @Published public var authorizationStatus: CLAuthorizationStatus
    @Published public var lastSeenLocation: CLLocation?

    public var isEnabled: Bool {
        locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse
    }

    private let locationManager: CLLocationManager

    override public init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    public func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
    }
}
