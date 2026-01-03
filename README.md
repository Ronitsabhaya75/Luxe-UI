# LuxeUI 

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%2015%2B%20%7C%20macOS%2012%2B-blue.svg" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-5.9%2B-orange.svg" alt="Swift">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
  <img src="https://img.shields.io/badge/SwiftUI-Native-purple.svg" alt="SwiftUI">
</p>

<p align="center">
  <img src="https://github.com/Ronitsabhaya75/Luxe-UI/actions/workflows/swift.yml/badge.svg" alt="Swift CI">
  <img src="https://github.com/Ronitsabhaya75/Luxe-UI/actions/workflows/tests.yml/badge.svg" alt="Tests">
</p>

<p align="center">
  <strong>The Premium UI Kit for 2026 - Alternative to Liquid UI for Lower macOS Versions</strong>
</p>

<p align="center">
  <img src="Assets/demo.gif" alt="LuxeUI Demo" width="600">
</p>

A beautiful, production-ready SwiftUI component library featuring the most advanced UI effects of 2026. LuxeUI brings premium design to macOS 12+ and iOS 15+, making cutting-edge UI accessible to everyone.

##  Why LuxeUI?

- **Refractive Glass Effects** - Real lens warping, not just blur
- **Intelligent Interactions** - Magnetic pull, smart springs, predictive layouts
- **Theme System** - Global design tokens that flow to all components
- **Smooth Animations** - 60 FPS physics-based motion
- **Zero Dependencies** - Pure SwiftUI, no external frameworks
- **Cross-Platform** - Works on macOS 12+ and iOS 15+
- **Well Documented** - Every API has examples and guides

##  Features

###  **Powerful Theme System**
- Global theme injection using `@Environment`
- 5 preset themes (Default, Midnight, Sunset, Ocean, Monochrome)
- Fully customizable design tokens (colors, typography, spacing, shadows, animations)
- Theme flows automatically to all components
- Real-time theme switching

###  **Premium Components**

#### 1. **LuxeCard** - Floating Glass Cards
Modern cards with hover effects, shimmer animations, and glassmorphic design.

```swift
import LuxeUI

LuxeCard {
    VStack(spacing: 12) {
        Image(systemName: "sparkles")
            .font(.system(size: 40))
        Text("Premium")
            .font(.headline)
        Text("Hover me!")
            .font(.caption)
    }
}
```

**Features:**
- Hover scale animation
- Shimmer gradient overlay
- Glowing border effects
- Smooth spring animations

#### 1.5. **Refractive Glass** - The 2026 Signature Effect ⭐
Physical lens-warping effect that actually distorts the background like real liquid glass.

```swift
// Simple modifier
VStack {
    Text("Premium Content")
}
.padding()
.refractiveGlass(intensity: 0.2)

// Or use the card component
RefractiveGlassCard(
    distortionIntensity: 0.25,
    chromaticAberration: true
) {
    VStack {
        Image(systemName: "wand.and.stars")
            .font(.largeTitle)
        Text("Liquid Glass")
    }
}
```

**Unique Features:**
- Real lens distortion at edges (not just blur!)
- Animated caustic light patterns
- Chromatic aberration (RGB separation)
- Multi-layer refractive depth
- Liquid shimmer animation
-  **Can't be easily built by hand** - this is why developers need LuxeUI!

[ Read the full Refractive Glass implementation guide](REFRACTIVE_GLASS_GUIDE.md)

#### 2. **LuxeButton** - Premium Buttons
Buttons with glass effects, gradients, and haptic feedback.

```swift
LuxeButton("Click Me", style: .primary) {
    print("Tapped!")
}

// Styles available
LuxeButton("Primary", style: .primary) { }
LuxeButton("Secondary", style: .secondary) { }
LuxeButton("Glass", style: .glass) { }
```

**Features:**
- Press animations
- Haptic feedback (iOS)
- Gradient or glass backgrounds
- Shadow effects

#### 3. **MeshGradientBackground** - Animated Backgrounds
Beautiful animated mesh gradients like macOS 15.

```swift
MeshGradientBackground(colors: [.purple, .pink, .blue])
```

**Features:**
- Floating animated orbs
- Smooth continuous animation
- Multiple color support
- Creates depth and atmosphere

#### 4. **CircularProgressBar** - Animated Progress Rings
Animated ring progress indicator with smooth animations.

```swift
CircularProgressBar(
    progress: 0.75,
    showPercentage: true,
    gradient: true,
    size: 160
)

// Size variants
CircularProgressBar.small(progress: 0.5)
CircularProgressBar.medium(progress: 0.65, showPercentage: true)
CircularProgressBar.large(progress: 0.9, showPercentage: true)
```

#### 5. **LuxeBadge** - Glowing Badges
Small badges with glow effects.

```swift
LuxeBadge("Premium UI", color: .purple)
```

#### 6. **Glassmorphism Container**
Modern frosted glass effect with customizable blur and transparency.

```swift
import LuxeUI

GlassmorphismContainer {
    VStack {
        Text("Hello, World!")
        Button("Click Me") { }
    }
}

// Or use the modifier
Text("Glass Effect")
    .glassmorphic()
```

#### 7. **Multi-Thumb Slider**
Slider with multiple draggable thumbs for range selection.

```swift
@State private var values: [Double] = [20, 80]

MultiThumbSlider(
    values: $values,
    range: 0...100,
    showLabels: true
)
```

#### 8. **FloatingOrb** - Animated Glowing Orbs
Atmospheric background elements with pulse animations.

```swift
FloatingOrb(size: 300, color: .purple)
```

---

##  **Visual Effects**

### Advanced Animations
- Spring-based smooth animations
- Hover effects with scale transforms
- Shimmer gradient overlays
- Pulse animations
- Continuous background animations

### Material & Blur
- Ultra-thin material effects
- Radial gradients for depth
- Multi-layer blur effects
- Frosted glass appearance

---

## **Quick Start**

### Swift Package Manager

Add LuxeUI to your project via Swift Package Manager:

1. In Xcode, go to **File → Add Packages...**
2. Enter the repository URL
3. Select your target and add the package

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/luxeUI.git", from: "1.0.0")
]
```

---

##  **Quick Start**

### 1. Import the package

```swift
import SwiftUI
import LuxeUI
```

### 2. Apply a theme at the root

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .luxeTheme(.midnight)  // Apply theme
        }
    }
}
```

### 3. Build Premium UI

All components automatically adapt to the theme:

```swift
struct ContentView: View {
    @State private var progress: Double = 0.75
    
    var body: some View {
        ZStack {
            // Animated mesh background
            MeshGradientBackground()
            
            ScrollView {
                VStack(spacing: 32) {
                    // Premium badge
                    LuxeBadge(text: "PREMIUM UI", style: .glow)
                    
                    // Hero card with hover effect
                    LuxeCard(
                        icon: "sparkles",
                        title: "Premium Design",
                        description: "Beautiful components with advanced effects"
                    )
                    
                    // Interactive progress
                    CircularProgressBar(
                        progress: progress,
                        showPercentage: true,
                        gradient: true
                    )
                    .frame(width: 200, height: 200)
                    
                    // Premium buttons
                    HStack(spacing: 16) {
                        LuxeButton(title: "Primary", style: .primary) {
                            print("Tapped!")
                        }
                        
                        LuxeButton(title: "Outline", style: .outline) {
                            print("Tapped!")
                        }
                    }
                }
                .padding()
            }
        }
    }
}
```

---

##  **Preset Themes**

- **`.default`** - Blue and purple accents
- **`.midnight`** - Dark with deep purples ⭐ (Recommended for premium UI)
- **`.sunset`** - Warm oranges and pinks  
- **`.ocean`** - Mint and teal tones
- **`.monochrome`** - Minimalist black and white

---

## ⚙️ **Custom Themes**

Create your own theme:

```swift
let customTheme = Theme(
    primaryColor: .blue,
    secondaryColor: .purple,
    accentColor: .pink,
    cornerRadiusMedium: 12,
    spacingM: 20,
    fontSizeBody: 16
)

ContentView()
    .luxeTheme(customTheme)
```

---

##  **Contributing**

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

- Found a bug? [Open an issue](https://github.com/yourusername/luxeui/issues)
- Have a feature idea? [Start a discussion](https://github.com/yourusername/luxeui/discussions)
- Want to contribute code? [Submit a PR](https://github.com/yourusername/luxeui/pulls)

---

## CI/CD Pipelines

LuxeUI uses GitHub Actions for continuous integration and automated workflows:

| Workflow | Badge | Description |
|----------|-------|-------------|
| **Swift CI** | ![Swift CI](https://github.com/Ronitsabhaya75/Luxe-UI/actions/workflows/swift.yml/badge.svg) | Builds package and runs tests on every push/PR |
| **Tests** | ![Tests](https://github.com/Ronitsabhaya75/Luxe-UI/actions/workflows/tests.yml/badge.svg) | Runs 60 unit tests across 19 test suites |
| **PR Labeler** | Auto | Automatically labels PRs based on changed files |

### Automated PR Labels

PRs are automatically labeled based on the files changed:

| Label | Trigger |
|-------|---------|
| `component` | Changes to `Sources/LuxeUI/Components/` |
| `theme` | Changes to `Sources/LuxeUI/Theme/` |
| `premium` | Changes to Premium components |
| `glass-effects` | Changes to Glassmorphism or Refractive Glass |
| `interactions` | Changes to Smart Spring or Predictive Layouts |
| `documentation` | Changes to `.md` files or `docs/` |
| `tests` | Changes to `Tests/` |
| `ci` | Changes to `.github/` workflows |
| `build` | Changes to `Package.swift` |

---

## 📄 **License**

LuxeUI is available under the MIT license. See [LICENSE](LICENSE) for details.

##  **Showcase**

Built something amazing with LuxeUI? We'd love to see it! Share your projects in [GitHub Discussions](https://github.com/yourusername/luxeui/discussions).

---

## 🛠 **Requirements**

- iOS 15.0+ / macOS 12.0+
- Swift 5.9+
- Xcode 15.0+

## Demo

Check out the included showcase view:

```swift
import LuxeUI

struct ContentView: View {
    var body: some View {
        LuxeUIShowcase()
    }
}
```

## Requirements

- iOS 15.0+ / macOS 12.0+
- Swift 5.9+
- Xcode 14.0+

## Architecture

LuxeUI is built with best practices:

- ✅ **`@ViewBuilder`** for flexible component composition
- ✅ **`@Environment`** for theme injection  
- ✅ **Public API** with proper access control
- ✅ **SwiftUI-native** animations and effects
- ✅ **Type-safe** design tokens
- ✅ **Sendable** compliance for Swift 6

## Project Structure

```
luxeUI/
├── .github/
│   ├── workflows/
│   │   ├── swift.yml              # Build & test CI
│   │   ├── tests.yml              # Dedicated test runner
│   │   ├── pr-label-analysis.yml  # PR file analysis (read-only)
│   │   └── pr-label-apply.yml     # Apply labels (write access)
│   ├── labeler.yml                # Label configuration
│   └── ISSUE_TEMPLATE/            # Issue templates
├── Sources/
│   └── LuxeUI/
│       ├── luxeUI.swift                # Main library entry point
│       ├── Theme/
│       │   ├── Theme.swift             # Theme model with design tokens
│       │   ├── ThemeEnvironment.swift  # Environment key
│       │   └── ThemeProvider.swift     # .luxeTheme() modifier
│       ├── Components/
│       │   ├── Containers/
│       │   │   ├── GlassmorphismContainer.swift
│       │   │   └── RefractiveGlassModifier.swift
│       │   ├── Premium/
│       │   │   └── PremiumComponents.swift
│       │   ├── Progress/
│       │   │   └── CircularProgressBar.swift
│       │   ├── Sliders/
│       │   │   └── MultiThumbSlider.swift
│       │   └── Interactions/
│       │       ├── SmartSpringEngine.swift
│       │       └── PredictiveLayouts.swift
│       └── Extensions/
│           └── View+Theme.swift
├── Tests/
│   └── luxeUITests/
│       └── luxeUITests.swift       
├── Examples/
│   └── README.md
├── docs/
├── Package.swift
├── README.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
└── LICENSE
```

## License

MIT License - feel free to use in your projects!

## Author

Created as part of the LuxeUI Style-System UI Kit project.
