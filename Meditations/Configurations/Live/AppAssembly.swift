import MeditationsClient
import MeditationsClientLive
import Swinject
import SwinjectAutoregistration

class AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MeditationsClient.self, factory: { _ in .live })
    }
}
