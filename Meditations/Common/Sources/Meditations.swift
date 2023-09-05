import Features
import SwiftUI
import Utilities

@main
struct BaseProject: App {
    init() {
        DI.initialize(assemblies: [
            AppAssembly(),
            FeaturesAssembly(),
            UtilitiesAssembly()
        ])
    }

    var body: some Scene {
        WindowGroup {
            MeditationsView()
        }
    }
}
