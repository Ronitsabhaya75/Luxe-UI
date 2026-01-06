# LuxeUI ✨

<p align="center">
  <a href="https://swiftpackageindex.com/Ronitsabhaya75/Luxe-UI">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FRonitsabhaya75%2FLuxe-UI%2Fbadge%3Ftype%3Dswift-versions" alt="Swift Versions">
  </a>
  <a href="https://swiftpackageindex.com/Ronitsabhaya75/Luxe-UI">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FRonitsabhaya75%2FLuxe-UI%2Fbadge%3Ftype%3Dplatforms" alt="Platforms">
  </a>
  <img src="https://img.shields.io/badge/Platform-iOS%2015%2B%20%7C%20macOS%2012%2B-blue.svg" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-5.9%2B-orange.svg" alt="Swift">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
  <img src="https://img.shields.io/badge/SwiftUI-Native-purple.svg" alt="SwiftUI">
</p>

LuxeUI is a **premium, high-performance UI framework** designed for 2026. It goes beyond standard components to provide "living" interfaces with refractive glassmorphism, fluid liquid effects, and intelligent spring physics.

---

## ✨ Features

### 1. Foundation (Core Components)
The backbone of modern, premium interfaces.
*   **Glassmorphism Engine**: `GlassmorphismContainer` & `LuxeCard` with multi-layered blur, saturation boost, and dynamic theme adaptation.
*   **Interactive Elements**: `LuxeButton` (Primary, Secondary, Glass, Custom), `LuxeBadge`.
*   **Cinematic Backgrounds**: `MeshGradientBackground` & `FloatingOrb` for depth and atmosphere.
*   **Data Visualization**: `MultiThumbSlider` (Range) & `CircularProgressBar` (Gradient).
*   **Theme System**: 8 Presets (Midnight, Neon, Ocean, Sunset, Forest, Monochrome, Light, Default).

### 2. Liquid UI (Premium Effects)
Organic, "gooey" components that feel alive.
*   **`LiquidLoader`**: Metaball loading animations where blobs merge fluidly.
*   **`LiquidButton`**: Interactive buttons with morphing, living backgrounds.
*   **`LiquidProgress`**: Wave-filled progress bars.
*   **`LiquidBlob`**: Standalone decorative elements that breath and morph.

### 3. Smart Interactions
*   **`SmartSpringEngine`**: Velocity-aware spring physics for natural motion.
*   **`MagneticPull`**: Elements that subtly attract the cursor.

---

## 🚀 Quick Start

### Installation

Add LuxeUI to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Ronitsabhaya75/Luxe-UI.git", from: "1.0.0")
]
```

### Usage Example

```swift
import SwiftUI
import LuxeUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Cinematic Background
            MeshGradientBackground(colors: [.purple, .blue, .black])
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Glass Card
                LuxeCard {
                    Text("Welcome to LuxeUI")
                        .font(.title.bold())
                }
                
                // Liquid Button
                LiquidButton("Get Started", configuration: .neon) {
                    print("Tapped!")
                }
            }
        }
    }
}
```

---

## 📱 Demos

Run the included demo apps to see the components in action:

**1. Foundation & Themes**
```bash
swift run CoreComponentsDemo
```

**2. Premium Liquid Effects**
```bash
swift run LiquidUIDemo
```

---

## 📚 Documentation
Full documentation is available in the [`docs/`](docs/) folder and [`documentation/`](documentation/) directory.

## 📄 License
MIT License - see [LICENSE](LICENSE) for details.
