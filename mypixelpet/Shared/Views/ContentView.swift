import SwiftUI

struct ContentView: View {
    @State private var pet = PetModel()

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.05)],
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                // Header
                VStack(spacing: 8) {
                    Text("My Pixel Pet")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    Text(pet.state.description)
                        .font(.subheadline)
                        .foregroundStyle(pet.state.color)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(pet.state.color.opacity(0.1))
                        .clipShape(Capsule())
                }
                .padding(.top, 40)

                Spacer()

                // Pet Avatar with Modern Animation
                ZStack {
                    Circle()
                        .fill(pet.state.color.opacity(0.1))
                        .frame(width: 200, height: 200)
                        .blur(radius: 20)

                    Text(pet.state.icon)
                        .font(.system(size: 100))
                        .shadow(color: pet.state.color.opacity(0.3), radius: 10, x: 0, y: 10)
                        .scaleEffect(pet.state == .normal ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: pet.state)
                }

                Spacer()

                // Status Bars
                VStack(spacing: 20) {
                    StatusRow(label: "Hunger",
                              value: pet.hunger,
                              icon: "fork.knife",
                              color: .orange)

                    StatusRow(label: "Happiness",
                              value: pet.happiness,
                              icon: "heart.fill",
                              color: .pink)
                }
                .padding(.horizontal, 30)

                // Interaction Buttons
                HStack(spacing: 20) {
                    ActionButton(title: "Feed",
                                 icon: "leaf.fill",
                                 color: .orange) {
                        pet.feed()
                    }

                    ActionButton(title: "Interact",
                                 icon: "hand.raised.fill",
                                 color: .pink) {
                        pet.interact()
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

// Subview for the Status Progress Bars
struct StatusRow: View {
    let label: String
    let value: Double
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: icon)
                Text(label)
                    .font(.caption.bold())
                Spacer()
                Text("\(Int(value))%")
                    .font(.caption.monospaced())
            }
            .foregroundStyle(color)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(color.opacity(0.1))

                    Capsule()
                        .fill(color.gradient)
                        .frame(width: geo.size.width * CGFloat(value / 100))
                }
            }
            .frame(height: 12)
        }
    }
}

// Subview for Premium Buttons
struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.gradient)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ContentView()
}
