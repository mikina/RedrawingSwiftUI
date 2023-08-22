import SwiftUI

@main
struct RedrawingSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
