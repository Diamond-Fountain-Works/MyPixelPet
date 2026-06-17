# MyPixelPet Platform Structure

## Recommendation

Use one repository with platform-specific app folders, not three unrelated repositories.

Recommended long-term layout:

```text
mypixelpet/
  apps/
    apple/
      mypixelpet.xcodeproj
      mypixelpet/
      mypixelpetTests/
      mypixelpetUITests/
    android/
      settings.gradle.kts
      build.gradle.kts
      app/
  shared/
    product/
      MyPixelPet.pages
      requirements.md
    assets/
      audio/
      icons/
      pixel-art/
    design/
      colors.md
      motion.md
  docs/
    platform-structure.md
    release-ios.md
    release-macos.md
    release-android.md
```

## Why One Repository

- iOS and macOS can share most SwiftUI models, services, views, assets, and release notes.
- Android will need its own Kotlin or Compose implementation, but it should follow the same product spec, visual assets, audio assets, and behavior rules.
- Keeping all platforms together reduces drift when pet stats, sounds, icons, copy, or app store metadata change.
- Separate folders still keep platform tooling clean: Xcode files stay under Apple, Gradle files stay under Android.

## When To Split Into Separate Repositories

Only split platforms into separate repositories if different teams own them, release cycles become independent, or app size/tooling becomes difficult to manage in one repo. That is not necessary at this stage.

## Current State

The current project is an iOS SwiftUI app with shared code already grouped under:

```text
mypixelpet/
  mypixelpet/
    Shared/
      Models/
      Services/
      Views/
      Resources/
    iOS/
    watchOS/
```

This is a good starting point for an Apple multi-target app. The next practical step is to add a macOS target to the existing Xcode project and keep reusable Swift code in `Shared`.

## Suggested Migration Order

1. Keep the current iOS app compiling as the source of truth.
2. Add a macOS target in the same Xcode project.
3. Move Apple-specific files into clearer Apple platform folders only after the macOS target builds.
4. Add `apps/android/` as a separate Android project when Android work starts.
5. Move common product specs, audio, pixel art, icons, and store metadata into `shared/`.

## Naming Rule

Use platform folders for code:

- `iOS`: iPhone and iPad app entry points, entitlements, Info.plist settings, iOS-only UI.
- `macOS`: macOS app entry points, menu commands, window behavior, macOS-only UI.
- `Android`: Gradle project and Android app implementation.
- `Shared`: product behavior, models, portable SwiftUI components for Apple, shared assets, and docs.
