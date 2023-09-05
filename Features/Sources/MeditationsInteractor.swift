import Combine
import CoreLocation
import Foundation
import MeditationsClient
import UIKit
import Utilities

final class MeditationsInteractor {
    let meditationsPublisher: PassthroughSubject<[Meditation], Never>
    let dataStateSubject: PassthroughSubject<DataState, Never>

    private let locationProvider: LocationProvider
    private let meditationsClient: MeditationsClient
    private var cancellables = Set<AnyCancellable>()

    init(meditationsClient: MeditationsClient, locationProvider: LocationProvider) {
        self.locationProvider = locationProvider
        self.meditationsClient = meditationsClient
        meditationsPublisher = PassthroughSubject<[Meditation], Never>()
        dataStateSubject = PassthroughSubject<DataState, Never>()
        dataStateSubject.send(.loading)
        unowned let unownedSelf = self

        if !locationProvider.isEnabled {
            meditationsClient.getMeditations(nil)
                .sink(
                    receiveCompletion: { completion in
                        if case .failure = completion {
                            unownedSelf.dataStateSubject.send(.error)
                        }
                    },
                    receiveValue: { meditations in
                        unownedSelf.meditationsPublisher.send(meditations)
                        unownedSelf.dataStateSubject.send(.loaded)
                    }
                )
                .store(in: &cancellables)
        }

        locationProvider.$lastSeenLocation
            .dropFirst()
            .handleEvents(receiveOutput: { _ in
                unownedSelf.dataStateSubject.send(.loading)
            })
            .flatMap { location -> AnyPublisher<[Meditation], ApiError> in
                self.meditationsClient.getMeditations(location?.coordinate).eraseToAnyPublisher()
            }
            .sink(
                receiveCompletion: { completion in
                    if case .failure = completion {
                        unownedSelf.dataStateSubject.send(.error)
                    }
                },
                receiveValue: { meditations in
                    unownedSelf.meditationsPublisher.send(meditations)
                    unownedSelf.dataStateSubject.send(.loaded)
                }
            )
            .store(in: &unownedSelf.cancellables)
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

enum DataState {
    case error
    case loading
    case loaded
}
