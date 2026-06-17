#if os(macOS)
import AppKit
import Observation
import SwiftUI

enum DesktopPetActivityState: String, CaseIterable, Identifiable {
    case idle
    case working
    case waitingForInput
    case readyForReview
    case sleeping

    var id: String { rawValue }

    var title: String {
        switch self {
        case .idle: return "Idle"
        case .working: return "Working"
        case .waitingForInput: return "Waiting"
        case .readyForReview: return "Review"
        case .sleeping: return "Sleeping"
        }
    }

    var prompt: String {
        switch self {
        case .idle: return "Ready"
        case .working: return "Working..."
        case .waitingForInput: return "Needs input"
        case .readyForReview: return "Ready to review"
        case .sleeping: return "Tucked away"
        }
    }

    var symbolName: String {
        switch self {
        case .idle: return "sparkle"
        case .working: return "gearshape.2.fill"
        case .waitingForInput: return "hand.tap.fill"
        case .readyForReview: return "checkmark.seal.fill"
        case .sleeping: return "moon.zzz.fill"
        }
    }

    var tint: Color {
        switch self {
        case .idle: return .teal
        case .working: return .indigo
        case .waitingForInput: return .orange
        case .readyForReview: return .green
        case .sleeping: return .secondary
        }
    }
}

@MainActor
@Observable
final class DesktopPetAppModel {
    static let shared = DesktopPetAppModel()

    let pet = PetModel()

    var activityState: DesktopPetActivityState = .idle
    var isVisible: Bool = true
    var isAlwaysOnTop: Bool = true {
        didSet {
            defaults.set(isAlwaysOnTop, forKey: DefaultsKey.alwaysOnTop)
            panelController.applyWindowOptions(from: self)
        }
    }
    var isClickThrough: Bool = false {
        didSet {
            defaults.set(isClickThrough, forKey: DefaultsKey.clickThrough)
            panelController.applyWindowOptions(from: self)
        }
    }
    var petSize: Double = 168 {
        didSet {
            defaults.set(petSize, forKey: DefaultsKey.petSize)
            panelController.applySize(from: self)
        }
    }

    private let panelController = DesktopPetPanelController()
    private let defaults = UserDefaults.standard

    private init() {
        isAlwaysOnTop = defaults.object(forKey: DefaultsKey.alwaysOnTop) as? Bool ?? true
        isClickThrough = defaults.object(forKey: DefaultsKey.clickThrough) as? Bool ?? false
        let savedSize = defaults.object(forKey: DefaultsKey.petSize) as? Double ?? 168
        petSize = min(max(savedSize, 112), 260)
    }

    func showPet() {
        activityState = activityState == .sleeping ? .idle : activityState
        isVisible = true
        panelController.show(model: self)
    }

    func tuckAwayPet() {
        activityState = .sleeping
        isVisible = false
        panelController.hide()
    }

    func togglePet() {
        isVisible ? tuckAwayPet() : showPet()
    }

    func feed() {
        pet.feed()
        activityState = .idle
    }

    func interact() {
        pet.interact()
        activityState = .readyForReview
    }

    func setDemoState(_ state: DesktopPetActivityState) {
        activityState = state
        if state == .sleeping {
            tuckAwayPet()
        } else if !isVisible {
            showPet()
        }
    }
}

private enum DefaultsKey {
    static let alwaysOnTop = "desktopPet.alwaysOnTop"
    static let clickThrough = "desktopPet.clickThrough"
    static let petSize = "desktopPet.size"
}
#endif
