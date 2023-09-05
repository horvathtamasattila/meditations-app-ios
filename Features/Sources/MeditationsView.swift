import SwiftUI

public struct MeditationsView: View {
    @StateObject var viewModel = inject(MeditationsViewModel.self)
    public init() {}
    public var body: some View {
        Text("Hello World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationsView()
    }
}
