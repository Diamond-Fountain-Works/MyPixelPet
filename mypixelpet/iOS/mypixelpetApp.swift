//
//  mypixelpetApp.swift
//  mypixelpet
//
//  Created by B. Ma on 2026/4/12.
//

import SwiftUI

@main
struct mypixelpetApp: App {
    // Initializing the MotionManager starts its accelerometer updates
    @State private var motionManager = MotionManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
