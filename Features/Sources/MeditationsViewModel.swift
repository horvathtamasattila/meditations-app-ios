import Combine
import MeditationsClient

final class MeditationsViewModel: ObservableObject {
    let interactor: MeditationsInteractor
    var cacellables = Set<AnyCancellable>()

    @Published var meditations: [Meditation] = []

    init(interactor: MeditationsInteractor) {
        self.interactor = interactor
        unowned let unownedSelf = self

        interactor.meditationsPublisher
            .assign(to: &$meditations)
    }

    func requestLocationDidtap() {
        interactor.requestLocationPermission()
    }
}
