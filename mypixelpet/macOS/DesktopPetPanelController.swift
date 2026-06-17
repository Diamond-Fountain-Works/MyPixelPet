#if os(macOS)
import AppKit
import SwiftUI

@MainActor
final class DesktopPetPanelController {
    private var panel: NSPanel?

    func show(model: DesktopPetAppModel) {
        let panel = panel ?? makePanel(model: model)
        self.panel = panel

        applyWindowOptions(from: model)
        applySize(from: model)
        panel.orderFrontRegardless()
    }

    func hide() {
        panel?.orderOut(nil)
    }

    func applyWindowOptions(from model: DesktopPetAppModel) {
        guard let panel else { return }
        panel.level = model.isAlwaysOnTop ? .floating : .normal
        panel.ignoresMouseEvents = model.isClickThrough
    }

    func applySize(from model: DesktopPetAppModel) {
        guard let panel else { return }

        let size = CGSize(width: model.petSize, height: model.petSize)
        var frame = panel.frame
        frame.size = size
        panel.setFrame(frame, display: true)
        panel.contentView = NSHostingView(
            rootView: DesktopPetOverlayView(model: model)
                .frame(width: size.width, height: size.height)
        )
    }

    private func makePanel(model: DesktopPetAppModel) -> NSPanel {
        let visibleFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1440, height: 900)
        let size = CGSize(width: model.petSize, height: model.petSize)
        let origin = CGPoint(
            x: visibleFrame.maxX - size.width - 32,
            y: visibleFrame.maxY - size.height - 48
        )

        let panel = DesktopPetPanel(
            contentRect: NSRect(origin: origin, size: size),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        panel.isReleasedWhenClosed = false
        panel.isOpaque = false
        panel.backgroundColor = .clear
        panel.hasShadow = false
        panel.hidesOnDeactivate = false
        panel.isMovableByWindowBackground = true
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .stationary]
        panel.contentView = NSHostingView(
            rootView: DesktopPetOverlayView(model: model)
                .frame(width: size.width, height: size.height)
        )

        return panel
    }
}

private final class DesktopPetPanel: NSPanel {
    override var canBecomeKey: Bool { false }
    override var canBecomeMain: Bool { false }

    override func mouseDown(with event: NSEvent) {
        performDrag(with: event)
    }
}
#endif
