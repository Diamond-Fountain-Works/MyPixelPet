#if os(macOS)
import SwiftUI

struct DesktopPetOverlayView: View {
    let model: DesktopPetAppModel
    @State private var pulse = false

    var body: some View {
        ZStack {
            Color.clear

            Text(model.pet.state.icon)
                .font(.system(size: iconSize))
                .shadow(color: .black.opacity(0.18), radius: 8, x: 0, y: 6)
                .scaleEffect(pulseScale)
                .accessibilityLabel(model.pet.state.description)
        }
        .contentShape(Rectangle())
        .onAppear {
            pulse = true
        }
        .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: pulse)
    }

    private var iconSize: CGFloat {
        max(44, CGFloat(model.petSize) * 0.62)
    }

    private var pulseScale: CGFloat {
        switch model.activityState {
        case .working:
            return pulse ? 1.08 : 0.98
        case .waitingForInput:
            return pulse ? 1.03 : 1.0
        case .readyForReview:
            return pulse ? 1.05 : 1.0
        case .idle, .sleeping:
            return 1.0
        }
    }
}
#endif
