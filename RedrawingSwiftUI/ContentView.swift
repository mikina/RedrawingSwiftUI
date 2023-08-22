import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        VStack {
            PositionView()
            TimelineView()
        }
        .padding()
        .environmentObject(viewModel)
    }
}
