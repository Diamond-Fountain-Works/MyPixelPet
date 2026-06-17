# MyPixelPet

<p align="center">
  <strong>A tiny cross-platform pixel companion, starting with a macOS floating desktop pet.</strong>
</p>

<p align="center">
  <a href="#english">English</a> ·
  <a href="#中文">中文</a> ·
  <a href="#日本語">日本語</a>
</p>

<p align="center">
  <img alt="Platform" src="https://img.shields.io/badge/platform-iOS%20%7C%20macOS-blue">
  <img alt="SwiftUI" src="https://img.shields.io/badge/UI-SwiftUI-orange">
  <img alt="Status" src="https://img.shields.io/badge/status-macOS%20MVP-green">
</p>

## English

MyPixelPet is a lightweight virtual pet project for Apple platforms first, with Android planned later. The current focus is a macOS floating overlay: a small transparent desktop companion that stays on screen, can be dragged around naturally, and reacts to pet state.

### Features

- **macOS floating pet overlay**: a borderless, transparent, always-available desktop pet.
- **Native dragging**: the pet window uses AppKit-native panel dragging for smoother pointer tracking.
- **Menu bar controls**: wake, tuck away, feed, interact, toggle always-on-top, and toggle click-through.
- **Shared pet model**: hunger, happiness, and state transitions are shared by the iOS and macOS experiences.
- **SwiftUI + AppKit bridge**: SwiftUI owns the pet UI; AppKit owns the specialized desktop overlay behavior.
- **Multi-platform direction**: iOS and macOS share Apple code, while Android is planned as a separate implementation using shared product specs and assets.

### Run macOS

```bash
./script/build_and_run.sh
```

The script builds the macOS destination with Xcode and opens the generated app from local DerivedData.

### Project Layout

```text
mypixelpet/
  mypixelpet/
    Shared/       # Shared models, services, views, and resources
    iOS/          # iOS app entry point
    macOS/        # Floating desktop pet overlay
  docs/           # Platform strategy and discovery docs
  script/         # Local build/run entry points
```

---

## 中文

MyPixelPet 是一个轻量级虚拟桌面宠物项目，先以 Apple 平台为核心，后续再扩展 Android。当前重点是 macOS floating overlay：一个透明、可拖拽、可以常驻屏幕的小宠物。

### 主要功能

- **macOS 桌面浮动宠物**：无边框、透明背景，只显示宠物本体。
- **原生拖拽手感**：使用 AppKit 原生 panel 拖拽，避免 SwiftUI 高频手动位移导致的卡顿。
- **菜单栏控制**：唤醒、收起、喂食、互动、置顶、点击穿透。
- **共享宠物模型**：饥饿值、快乐值和宠物状态在 iOS 与 macOS 之间复用。
- **SwiftUI + AppKit 架构**：宠物 UI 用 SwiftUI，桌面浮层窗口行为由 AppKit 管理。
- **多平台规划**：iOS/macOS 共用 Apple 端代码，Android 后续单独实现，但复用产品规则、素材和文档。

### 运行 macOS 版本

```bash
./script/build_and_run.sh
```

脚本会构建 macOS 目标，并打开本地 DerivedData 中生成的 app。

### 项目结构

```text
mypixelpet/
  mypixelpet/
    Shared/       # 共享模型、服务、视图和资源
    iOS/          # iOS app 入口
    macOS/        # macOS 桌面浮动宠物
  docs/           # 平台规划与可发现性文档
  script/         # 本地构建和运行脚本
```

---

## 日本語

MyPixelPet は、まず Apple プラットフォーム向けに開発している軽量なバーチャルペットプロジェクトです。現在の中心機能は macOS の floating overlay で、透明なデスクトップ上の小さなペットを自然にドラッグして使えます。

### 主な機能

- **macOS フローティングペット**: 枠や背景を持たない、透明なデスクトップペット。
- **ネイティブなドラッグ操作**: AppKit の panel ドラッグを使い、ポインタに自然に追従します。
- **メニューバー操作**: 表示、非表示、餌やり、インタラクション、常に手前、クリック透過を切り替え可能。
- **共有ペットモデル**: 空腹度、幸福度、状態遷移を iOS と macOS で共有。
- **SwiftUI + AppKit 構成**: ペット UI は SwiftUI、特殊なデスクトップウィンドウ制御は AppKit が担当。
- **マルチプラットフォーム計画**: iOS/macOS は Apple 側で共有し、Android は後から独立実装として追加予定。

### macOS 版の起動

```bash
./script/build_and_run.sh
```

このスクリプトは Xcode で macOS ターゲットをビルドし、生成された app を起動します。

### ディレクトリ構成

```text
mypixelpet/
  mypixelpet/
    Shared/       # 共有モデル、サービス、ビュー、リソース
    iOS/          # iOS app エントリーポイント
    macOS/        # macOS デスクトップペット overlay
  docs/           # プラットフォーム方針と発見性ドキュメント
  script/         # ローカルビルド/実行スクリプト
```

## Roadmap

- Replace emoji placeholders with original pixel-art pet sprites.
- Add pet animations for idle, working, waiting, happy, bored, and fainted states.
- Persist pet position and behavior settings.
- Add a dedicated macOS settings surface for appearance and behavior.
- Add Android implementation after the Apple desktop experience is stable.

## Documentation

- [Platform structure](docs/platform-structure.md)
- [GEO and discovery profile](docs/GEO.md)
