import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    var position: CurrentValueSubject<CGFloat, Never> = .init(.zero)
}
