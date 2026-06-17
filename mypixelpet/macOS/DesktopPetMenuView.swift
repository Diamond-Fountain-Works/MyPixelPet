#if os(macOS)
import SwiftUI

struct DesktopPetMenuView: View {
    let model: DesktopPetAppModel
    @Environment(\.openSettings) private var openSettings

    var body: some View {
        Button(model.isVisible ? "Tuck Away Pet" : "Wake Pet") {
            model.togglePet()
        }
        .keyboardShortcut("p", modifiers: [.command, .shift])

        Divider()

        Button("Feed") {
            model.feed()
            model.showPet()
        }

        Button("Interact") {
            model.interact()
            model.showPet()
        }

        Menu("Demo Status") {
            ForEach(DesktopPetActivityState.allCases.filter { $0 != .sleeping }) { state in
                Button(state.title) {
                    model.setDemoState(state)
                }
            }
        }

        Divider()

        Toggle("Always on Top", isOn: Bindable(model).isAlwaysOnTop)
        Toggle("Click Through", isOn: Bindable(model).isClickThrough)

        Button("Settings...") {
            openSettings()
        }
        .keyboardShortcut(",", modifiers: .command)

        Divider()

        Button("Quit MyPixelPet") {
            NSApp.terminate(nil)
        }
        .keyboardShortcut("q", modifiers: .command)
    }
}
#endif
