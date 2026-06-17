//
//  mypixelpetApp.swift
//  mypixelpet
//
//  Created by B. Ma on 2026/4/12.
//

import SwiftUI
#if os(macOS)
import AppKit
#endif

@main
struct mypixelpetApp: App {
#if os(macOS)
    @NSApplicationDelegateAdaptor(MacAppDelegate.self) private var appDelegate
    @State private var desktopPet = DesktopPetAppModel.shared

    var body: some Scene {
        MenuBarExtra("MyPixelPet", systemImage: "pawprint.fill") {
            DesktopPetMenuView(model: desktopPet)
        }
        .menuBarExtraStyle(.menu)

        Settings {
            DesktopPetSettingsView(model: desktopPet)
        }
    }
#else
    // Initializing the MotionManager starts its accelerometer updates
    @State private var motionManager = MotionManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
#endif
}

#if os(macOS)
final class MacAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        DesktopPetAppModel.shared.showPet()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }
}
#endif
