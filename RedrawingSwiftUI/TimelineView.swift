import SwiftUI

struct TimelineView: View {
    @EnvironmentObject var viewModel: ContentViewModel

    var length: CGFloat = 20
    var fps: CGFloat = 30

    private let coordinateSpaceName = "TimelineScroll"

    var body: some View {
        VStack {
            ZStack {
                ScrollViewReader { value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        ZStack {
                            GeometryReader { proxy in
                                let x = proxy.frame(in: .named(coordinateSpaceName)).minX
                                let y = proxy.frame(in: .named(coordinateSpaceName)).minY

                                Color.clear
                                    .preference(key: ScrollViewOffsetPreferenceKey.self, value: CGPoint(x: x * -1, y: y * -1))
                            }
                            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                                viewModel.position.send(value.x)
                            }

                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 0) {
                                    TimeIndicator(length: length, fps: fps)
                                        .frame(height: 20)
                                }
                            }
                        }
                    }
                    .coordinateSpace(name: coordinateSpaceName)
                }
            }
            .frame(height: 100)
            .border(.debug)
        }
    }
}

extension ShapeStyle where Self == Color {
    static var debug: Color {
        Color(
            red: .random(in: 0 ... 1),
            green: .random(in: 0 ... 1),
            blue: .random(in: 0 ... 1)
        )
    }
}

struct TimeIndicator: View {
    let length: CGFloat
    let fps: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            LazyHStack(spacing: 0) {
                ForEach(0 ..< Int(length) + 15, id: \.self) { index in
                    Text("\(index)")
                        .font(.system(size: 9))
                        .frame(width: fps * 0.75)
                        .foregroundColor(.black)
                        .background(.white)
                        .padding(.top, 1)
                        .id(index)

                    Text("·")
                        .font(.system(size: 9))
                        .frame(width: fps * 0.25)
                        .foregroundColor(.black)
                        .background(.white)
                        .padding(.top, 1)
                }
            }
        }
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }

    typealias Value = CGPoint
}
