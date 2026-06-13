import SwiftUI
import Observation

enum PetState {
    case normal
    case fainted
    case bored
    case faintedAndBored

    var icon: String {
        switch self {
        case .normal: return "🙂"
        case .fainted: return "😵"
        case .bored: return "😑"
        case .faintedAndBored: return "💀"
        }
    }

    var color: Color {
        switch self {
        case .normal: return .green
        case .fainted: return .red
        case .bored: return .orange
        case .faintedAndBored: return .purple
        }
    }

    var description: String {
        switch self {
        case .normal: return "Feeling Great!"
        case .fainted: return "Pet has Fainted!"
        case .bored: return "Pet is Bored!"
        case .faintedAndBored: return "The pet is fainted and bored!"
        }
    }
}

@Observable
class PetModel {
    var hunger: Double = 100.0
    var happiness: Double = 100.0
    private var timer: Timer?

    var state: PetState {
        if hunger <= 0 && happiness <= 0 {
            return .faintedAndBored
        } else if hunger <= 0 {
            return .fainted
        } else if happiness <= 0 {
            return .bored
        } else {
            return .normal
        }
    }

    init() {
        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateStats()
        }
    }

    private func updateStats() {
        // Linear reduction for now, extensible for complex functions later
        let reduction: Double = 10.0

        withAnimation(.smooth) {
            hunger = max(0, hunger - reduction)
            happiness = max(0, happiness - reduction)
        }
    }

    func feed() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            hunger = min(100, hunger + 20)
        }
    }

    func interact() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            happiness = min(100, happiness + 20)
        }
    }
}
