import SwiftUI

public struct MeditationsView: View {
    @StateObject var viewModel = inject(MeditationsViewModel.self)
    public init() {}
    public var body: some View {
        ZStack {
            Color.secondaryGray
            cardView(title: "Title", description: "Description", audioLenght: 4)
                .padding(.horizontal, 16)
        }
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
