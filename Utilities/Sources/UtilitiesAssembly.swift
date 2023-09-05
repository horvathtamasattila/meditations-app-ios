import Swinject
import SwinjectAutoregistration

public class UtilitiesAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.autoregister(LocationProvider.self, initializer: LocationProvider.init)
    }
}
