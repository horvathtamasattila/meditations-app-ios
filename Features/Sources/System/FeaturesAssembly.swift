import Swinject
import SwinjectAutoregistration

public class FeaturesAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.autoregister(MeditationsViewModel.self, initializer: MeditationsViewModel.init)
        container.autoregister(MeditationsInteractor.self, initializer: MeditationsInteractor.init)
    }
}
