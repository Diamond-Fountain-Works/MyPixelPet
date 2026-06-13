import Foundation
import CoreMotion
import SwiftUI

@Observable
class MotionManager {
    static let shared = MotionManager()

    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()

    // Configurable Thresholds
    var slapThreshold: Double = 3.0 // Acceleration in Gs for a single slap
    var shakeThreshold: Double = 4.0 // Acceleration in Gs for a shake peak
    var coolDownPeriod: TimeInterval = 1.0 // Seconds between triggers

    private var lastTriggerTime: Date = Date.distantPast
    private var accelerationPeaks: [Date] = []

    init() {
        startAccelerometerUpdates()
    }

    func startAccelerometerUpdates() {
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer not available")
            return
        }

        motionManager.accelerometerUpdateInterval = 1.0 / 60.0 // 60Hz

        motionManager.startAccelerometerUpdates(to: queue) { [weak self] (data, error) in
            guard let self = self, let data = data else { return }

            let x = data.acceleration.x
            let y = data.acceleration.y
            let z = data.acceleration.z
            let magnitude = sqrt(x*x + y*y + z*z)

            // Core Logic: Distinguish between single slap and continuous shake
            if magnitude > self.shakeThreshold {
                self.handleHighAcceleration(magnitude: magnitude, isShakePeak: true)
            } else if magnitude > self.slapThreshold {
                self.handleHighAcceleration(magnitude: magnitude, isShakePeak: false)
            }
        }
    }

    private func handleHighAcceleration(magnitude: Double, isShakePeak: some Any) {
        let now = Date()

        // Basic debounce to avoid multiple triggers for the same physical impact frame
        guard now.timeIntervalSince(lastTriggerTime) > 0.3 else { return }

        // Track the peak for shake detection
        accelerationPeaks.append(now)
        accelerationPeaks = accelerationPeaks.filter { now.timeIntervalSince($0) <= 1.0 }

        if accelerationPeaks.count >= 3 {
            // SHAKE DETECTED
            triggerShakeEffect()
            accelerationPeaks.removeAll()
        } else {
            // SINGLE SLAP DETECTED
            triggerSlapEffect()
        }

        lastTriggerTime = now
    }

    private func triggerSlapEffect() {
        print("Motion: SLAP")
        DispatchQueue.main.async {
            AudioManager.shared.playSound(named: "slap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                AudioManager.shared.playSound(named: "hurt")
            }
        }
    }

    private func triggerShakeEffect() {
        print("Motion: SHAKE (Fainting)")
        DispatchQueue.main.async {
            AudioManager.shared.playSound(named: "fainting")
        }
    }
}
