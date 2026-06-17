import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    private var audioPlayers: [String: AVAudioPlayer] = [:]

    private init() {
#if os(macOS)
        // macOS does not use AVAudioSession; AVAudioPlayer can play bundled sounds directly.
#else
        // Prepare shared audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
#endif
    }

    /// Plays a sound file from the Shared resources hierarchy.
    /// Named corresponds to the filename without extension (e.g., "fainting")
    func playSound(named name: String) {
        // Path mapping based on our recent organization
        // We'll search for the file in the bundle
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Could not find sound file: \(name).mp3")
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()

            // Keep reference to prevent ARC from deallocating while playing
            audioPlayers[name] = player
        } catch {
            print("Error playing sound \(name): \(error.localizedDescription)")
        }
    }
}
