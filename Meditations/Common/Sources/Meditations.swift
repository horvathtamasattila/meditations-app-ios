import Features
import SwiftUI

@main
struct BaseProject: App {
    init() {
        DI.initialize(assemblies: [
            AppAssembly(),
            FeaturesAssembly()
        ])
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
