import Combine
import CoreLocation
import Foundation
import MeditationsClient
import UIKit
import Utilities

final class MeditationsInteractor {
    let meditationsPublisher: PassthroughSubject<[Meditation], Never>

    private let locationProvider: LocationProvider
    private let meditationsClient: MeditationsClient
    private var cancellables = Set<AnyCancellable>()

    init(meditationsClient: MeditationsClient, locationProvider: LocationProvider) {
        self.locationProvider = locationProvider
        self.meditationsClient = meditationsClient
        meditationsPublisher = PassthroughSubject<[Meditation], Never>()
        unowned let unownedSelf = self

        if !locationProvider.isEnabled {
            meditationsClient.getMeditations(nil)
                .sink(
                    receiveCompletion: { _ in
                    },
                    receiveValue: { meditations in
                        unownedSelf.meditationsPublisher.send(meditations)
                    }
                )
                .store(in: &cancellables)
        }

        locationProvider.$lastSeenLocation
            .flatMap { location -> AnyPublisher<[Meditation], ApiError> in
                self.meditationsClient.getMeditations(location?.coordinate).eraseToAnyPublisher()
            }
            .sink(
                receiveCompletion: { _ in
                },
                receiveValue: { meditations in
                    unownedSelf.meditationsPublisher.send(meditations)
                }
            )
            .store(in: &cancellables)
    }

    func requestLocationPermission() {
        if locationProvider.authorizationStatus == .denied {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) { UIApplication.shared.open(settingsUrl) }
        } else {
            locationProvider.requestPermission()
        }
    }
}
