import SwiftUI

public struct MeditationsView: View {
    @StateObject var viewModel = inject(MeditationsViewModel.self)
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack {
                Spacer()
                Image(systemName: "location.circle")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.gray)
                    .padding(.trailing, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 32)
                    .onTapGesture {
                        viewModel.requestLocationDidtap()
                    }
            }
            Text("Meditations")
                .font(.font(type: .spaceGrotesk, size: 36))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.textLeading, .texttrailing],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .padding(.leading, 16)
                .padding(.bottom, 32)
            ScrollView {
                switch viewModel.viewState {
                case .loading:
                    VStack {
                        ForEach(0 ... 2, id: \.self) { _ in
                            cardView(
                                title: "Placeholder Title",
                                description: "Placeholder Description",
                                audioLenght: 100
                            )
                            .redacted(reason: .placeholder)
                        }
                    }
                case .loaded:
                    ForEach(viewModel.meditations, id: \.self) { meditation in
                        cardView(
                            title: meditation.title,
                            description: meditation.subtitle,
                            audioLenght: meditation.audioLength
                        )
                        .padding(.horizontal, 16)
                    }
                case .error:
                    Text("Couldn't load data")
                }
            }
        }
        .background(
            Color.secondaryGray.edgesIgnoringSafeArea(.all)
        )
    }

    func cardView(title: String, description: String, audioLenght: Int?) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: .zero) {
                Text(title)
                    .font(.font(type: .spaceGrotesk, size: 24))
                    .foregroundColor(.primaryText)
                    .padding(.bottom, 8)
                Text(description)
                    .font(.font(type: .spaceGrotesk, size: 16))
                    .foregroundColor(.secondaryText)
            }
            .padding(.leading, 16)
            .padding(.vertical, 32)
            Spacer()
            if let audioLenght = audioLenght {
                Text("\(audioLenght.description) min")
                    .font(.font(type: .spaceGrotesk, size: 24))
                    .foregroundColor(.primaryText)
                    .padding(.trailing, 8)
            }
        }
        .background(
            HStack {
                Spacer()
                Image("ripple_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: 12, y: 0)
                    .scaleEffect(2)
            }
            .background(Color.primaryGray)
        )
        .cornerRadius(8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationsView()
    }
}
