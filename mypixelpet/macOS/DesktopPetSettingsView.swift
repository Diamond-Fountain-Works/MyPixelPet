#if os(macOS)
import SwiftUI

struct DesktopPetSettingsView: View {
    let model: DesktopPetAppModel

    var body: some View {
        Form {
            Section("Overlay") {
                Toggle("Always on Top", isOn: Bindable(model).isAlwaysOnTop)
                Toggle("Click Through", isOn: Bindable(model).isClickThrough)

                HStack {
                    Text("Size")
                    Slider(value: Bindable(model).petSize, in: 112...260, step: 4)
                    Text("\(Int(model.petSize))")
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                        .frame(width: 36, alignment: .trailing)
                }
            }

            Section("Pet") {
                Picker("Status", selection: Bindable(model).activityState) {
                    ForEach(DesktopPetActivityState.allCases) { state in
                        Text(state.title).tag(state)
                    }
                }
                .pickerStyle(.menu)

                HStack {
                    Button("Feed") {
                        model.feed()
                        model.showPet()
                    }
                    Button("Interact") {
                        model.interact()
                        model.showPet()
                    }
                }
            }
        }
        .formStyle(.grouped)
        .padding(20)
        .frame(width: 360)
    }
}
#endif
