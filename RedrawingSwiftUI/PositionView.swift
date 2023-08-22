import SwiftUI

struct PositionView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @State var position: CGFloat = .zero

    var body: some View {
        Text("Position: \(position)")
            .border(.debug)
            .onReceive(viewModel.position) { value in
                position = value
            }
    }
}
