# LuxeUI API Reference

Complete API documentation for LuxeUI - A premium SwiftUI component library with advanced theming, glassmorphism effects, and intelligent interactions.

---


## Table of Contents

- [Installation](#installation)

- [Quick Start](#quick-start)

- [Theme System](#theme-system)
  - [Theme](#theme)
  - [ThemePreset](#themepreset)
  - [LuxeColorScheme](#luxecolorscheme)
  - [LuxeTypography](#luxetypography)
  - [LuxeSpacing](#luxespacing)
  - [LuxeBorderRadius](#luxeborderradius)
  - [LuxeEffects](#luxeeffects)
  - [ThemeProvider](#themeprovider)
  - [ThemeReader](#themereader)
  
- [Components](#components)
  - [LuxeCard](#luxecard)
  - [LuxeButton](#luxebutton)
  - [LuxeBadge](#luxebadge)
  - [GlassmorphismContainer](#glassmorphismcontainer)
  - [CircularProgressBar](#circularprogressbar)
  - [MultiThumbSlider](#multithumbslider)
  - [FloatingOrb](#floatingorb)
  - [MeshGradientBackground](#meshgradientbackground)
- [View Modifiers](#view-modifiers)
  - [.refractiveGlass()](#refractiveglass)
  - [.smartSprings()](#smartsprings)
  - [.magneticPull()](#magneticpull)
- [Predictive Layouts](#predictive-layouts)
  - [LuxeAdaptiveContainer](#luxeadaptivecontainer)
  - [SmartFormButton](#smartformbutton)
- [Utilities](#utilities)
  - [TactileFeedback](#tactilefeedback)

---

## Installation

### Swift Package Manager

Add LuxeUI to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Ronitsabhaya75/Luxe-UI.git", from: "1.0.0")
]
```

Or in Xcode: **File → Add Package Dependencies** → Enter the repository URL.

---

## Quick Start

```swift
import SwiftUI
import LuxeUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .luxeTheme(.midnight)  // Apply a preset theme
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            LuxeCard {
                Text("Welcome to LuxeUI")
                    .font(.title)
            }
            
            LuxeButton("Get Started", style: .primary) {
                print("Button tapped!")
            }
        }
        .padding()
    }
}
```

---

## Theme System

### Theme

The central configuration object that controls the visual appearance of all LuxeUI components.

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `primaryColor` | `Color` | `.blue` | Primary brand color for main actions |
| `secondaryColor` | `Color` | `.purple` | Secondary brand color |
| `accentColor` | `Color` | `.cyan` | Accent color for emphasis |
| `backgroundColor` | `Color` | Dark blue | Main background color |
| `surfaceColor` | `Color` | Dark gray | Surface color for cards |
| `textColor` | `Color` | `.white` | Primary text color |
| `textSecondaryColor` | `Color` | White 70% | Secondary text color |
| `colors` | `LuxeColorScheme` | - | Complete semantic color scheme |
| `typography` | `LuxeTypography` | - | Typography settings |
| `spacing` | `LuxeSpacing` | - | Spacing scale |
| `borderRadius` | `LuxeBorderRadius` | - | Corner radius scale |
| `effects` | `LuxeEffects` | - | Shadow, blur, animation values |
| `enableHaptics` | `Bool` | `true` | Global haptic feedback toggle |

#### Preset Themes

| Preset | Description |
|--------|-------------|
| `.default` | Blue/purple with dark background |
| `.midnight` | Deep purple with very dark background |
| `.sunset` | Warm orange/red tones |
| `.ocean` | Cool blue/teal tones |
| `.forest` | Natural green tones |
| `.neon` | Vibrant pink/cyan for bold designs |
| `.monochrome` | Black, white, and gray |
| `.light` | Light mode with white background |

#### Usage

```swift
// Apply preset theme
ContentView()
    .luxeTheme(.midnight)

// Create custom theme
let customTheme = Theme(
    primaryColor: .orange,
    secondaryColor: .red,
    accentColor: .yellow,
    cornerRadius: 20
)
ContentView()
    .luxeTheme(customTheme)

// Builder pattern
let modified = Theme.default
    .withPrimaryColor(.green)
    .withAccentColor(.mint)
    .withHaptics(false)
```

#### Builder Methods

| Method | Description |
|--------|-------------|
| `.withPrimaryColor(_:)` | Set primary color |
| `.withSecondaryColor(_:)` | Set secondary color |
| `.withAccentColor(_:)` | Set accent color |
| `.withBackgroundColor(_:)` | Set background color |
| `.withTypography(_:)` | Set typography settings |
| `.withSpacing(_:)` | Set spacing scale |
| `.withEffects(_:)` | Set effects configuration |
| `.withHaptics(_:)` | Enable/disable haptics |

---

### ThemePreset

Enum for selecting preset themes.

```swift
public enum ThemePreset: String, CaseIterable {
    case `default`, midnight, sunset, ocean, forest, neon, monochrome, light
    
    var theme: Theme { ... }
}
```

---

### LuxeColorScheme

Comprehensive color palette for semantic colors.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `primary` | `Color` | `.blue` | Primary brand color |
| `secondary` | `Color` | `.purple` | Secondary brand color |
| `accent` | `Color` | `.cyan` | Accent color |
| `background` | `Color` | Dark | Main background |
| `surface` | `Color` | Dark gray | Card/container surface |
| `text` | `Color` | `.white` | Primary text |
| `textSecondary` | `Color` | White 70% | Muted text |
| `success` | `Color` | `.green` | Success states |
| `warning` | `Color` | `.orange` | Warning states |
| `error` | `Color` | `.red` | Error states |
| `info` | `Color` | `.cyan` | Informational states |

---

### LuxeTypography

Typography settings with font size scale and weights.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `fontSizeXS` | `CGFloat` | `10` | Extra small (fine print) |
| `fontSizeS` | `CGFloat` | `12` | Small (captions) |
| `fontSizeM` | `CGFloat` | `14` | Medium (body) |
| `fontSizeL` | `CGFloat` | `16` | Large (emphasized) |
| `fontSizeXL` | `CGFloat` | `20` | Extra large (subheadings) |
| `fontSizeXXL` | `CGFloat` | `24` | Double XL (headings) |
| `fontSizeDisplay` | `CGFloat` | `36` | Display (hero text) |
| `fontWeightLight` | `Font.Weight` | `.light` | Light weight |
| `fontWeightRegular` | `Font.Weight` | `.regular` | Regular weight |
| `fontWeightMedium` | `Font.Weight` | `.medium` | Medium weight |
| `fontWeightSemibold` | `Font.Weight` | `.semibold` | Semibold weight |
| `fontWeightBold` | `Font.Weight` | `.bold` | Bold weight |
| `lineHeightTight` | `CGFloat` | `1.2` | Tight line height |
| `lineHeightNormal` | `CGFloat` | `1.5` | Normal line height |
| `lineHeightRelaxed` | `CGFloat` | `1.8` | Relaxed line height |

---

### LuxeSpacing

Consistent spacing scale for layout.

| Property | Size | Description |
|----------|------|-------------|
| `xxxs` | `2pt` | Hairline spacing |
| `xxs` | `4pt` | Tight spacing |
| `xs` | `8pt` | Compact spacing |
| `s` | `12pt` | Small spacing |
| `m` | `16pt` | Medium spacing (default) |
| `l` | `24pt` | Large spacing |
| `xl` | `32pt` | Extra large spacing |
| `xxl` | `48pt` | Section spacing |
| `xxxl` | `64pt` | Major section spacing |

---

### LuxeBorderRadius

Corner radius scale.

| Property | Size | Description |
|----------|------|-------------|
| `none` | `0pt` | Sharp corners |
| `xs` | `4pt` | Subtle rounding |
| `s` | `8pt` | Small rounding |
| `m` | `12pt` | Medium rounding |
| `l` | `16pt` | Large rounding |
| `xl` | `24pt` | Extra large rounding |
| `full` | `9999pt` | Pill/capsule shape |

---

### LuxeEffects

Visual effect values for shadows, blurs, and animations.

| Property | Default | Description |
|----------|---------|-------------|
| `shadowSmall` | `4pt` | Subtle elevation |
| `shadowMedium` | `8pt` | Standard cards |
| `shadowLarge` | `16pt` | Prominent elements |
| `shadowXL` | `32pt` | Floating elements |
| `blurSmall` | `8pt` | Light blur |
| `blurMedium` | `16pt` | Medium blur |
| `blurLarge` | `32pt` | Heavy blur |
| `glowSmall` | `4pt` | Subtle glow |
| `glowMedium` | `8pt` | Standard glow |
| `glowLarge` | `16pt` | Prominent glow |
| `animationFast` | `0.15s` | Micro-interactions |
| `animationNormal` | `0.3s` | Standard transitions |
| `animationSlow` | `0.5s` | Emphasis animations |

---

### ThemeProvider

Container view that provides theme context with animated transitions.

```swift
ThemeProvider(theme: .midnight) {
    ContentView()
}

// With configuration
ThemeProvider(configuration: .smooth) {
    ContentView()
}
    .theme(.ocean)
    .animated(true)
    .animationDuration(0.4)
```

#### Configuration Presets

| Preset | Animation | Duration |
|--------|-----------|----------|
| `.default` | Yes | 0.3s |
| `.instant` | No | - |
| `.smooth` | Yes | 0.5s |

---

### ThemeReader

Read current theme in custom views.

```swift
ThemeReader { theme in
    Text("Custom Component")
        .foregroundColor(theme.primaryColor)
        .font(.system(size: theme.typography.fontSizeL))
}
```

---

## Components

### LuxeCard

Premium floating glass card with hover effects, press animations, and haptic feedback.

#### Initializers

```swift
// With configuration
LuxeCard(configuration: .prominent) {
    // Content
}

// With parameters
LuxeCard(
    cornerRadius: 24,
    blur: 12,
    backgroundOpacity: 0.2,
    hoverScale: 1.05,
    enableHaptics: true
) {
    // Content
}
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `cornerRadius` | `CGFloat` | `20` | Corner radius |
| `blur` | `CGFloat` | `10` | Glass blur radius |
| `backgroundOpacity` | `Double` | `0.15` | Background fill opacity |
| `borderWidth` | `CGFloat` | `1` | Border stroke width |
| `borderOpacity` | `Double` | `0.3` | Border opacity |
| `shadowColor` | `Color` | `.black` | Shadow color |
| `shadowRadius` | `CGFloat` | `20` | Shadow blur radius |
| `shadowX` | `CGFloat` | `0` | Shadow horizontal offset |
| `shadowY` | `CGFloat` | `10` | Shadow vertical offset |
| `hoverScale` | `CGFloat` | `1.02` | Scale on hover |
| `pressScale` | `CGFloat` | `0.98` | Scale on press |
| `animationResponse` | `Double` | `0.3` | Spring response |
| `animationDamping` | `Double` | `0.7` | Spring damping |
| `enableHaptics` | `Bool` | `true` | Enable haptic feedback |

#### Configuration Presets

| Preset | Description |
|--------|-------------|
| `.default` | Balanced settings |
| `.compact` | Smaller, subtle effects |
| `.prominent` | Large, bold appearance |
| `.subtle` | Minimal, understated |
| `.floating` | Maximum elevation |

#### Modifier Methods

```swift
LuxeCard { content }
    .onTap { print("Tapped") }
    .onHoverStart { print("Hover began") }
    .onHoverEnd { print("Hover ended") }
    .cardCornerRadius(24)
    .cardShadow(color: .blue, radius: 30)
    .cardHoverEffect(scale: 1.05)
    .cardPressEffect(scale: 0.95)
```

---

### LuxeButton

Premium button with gradient backgrounds, press animations, and haptic feedback.

#### Initializers

```swift
// Standard
LuxeButton("Get Started", style: .primary) {
    // Action
}

// With configuration
LuxeButton("Submit", style: .glass, configuration: .large) {
    // Action
}

// Static size helpers
LuxeButton.small("Cancel", style: .secondary) { }
LuxeButton.medium("Continue", style: .primary) { }
LuxeButton.large("Sign Up", style: .primary) { }
```

#### Styles

| Style | Description |
|-------|-------------|
| `.primary` | Gradient using theme primary/accent colors |
| `.secondary` | Uses theme secondary color |
| `.glass` | Frosted glass effect |
| `.custom(background:foreground:shadowColor:)` | Custom colors |

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `cornerRadius` | `CGFloat` | `12` | Corner radius |
| `fontSize` | `CGFloat` | `16` | Text font size |
| `fontWeight` | `Font.Weight` | `.semibold` | Text weight |
| `paddingHorizontal` | `CGFloat` | `24` | Horizontal padding |
| `paddingVertical` | `CGFloat` | `12` | Vertical padding |
| `shadowRadius` | `CGFloat` | `10` | Shadow blur |
| `pressScale` | `CGFloat` | `0.95` | Scale on press |
| `enableHaptics` | `Bool` | `true` | Enable haptics |
| `hapticIntensity` | `Intensity` | `.medium` | Haptic strength |

#### Size Presets

| Preset | Font Size | Padding H | Padding V |
|--------|-----------|-----------|-----------|
| `.small` | 14 | 16 | 8 |
| `.medium` | 16 | 24 | 12 |
| `.large` | 18 | 32 | 16 |
| `.extraLarge` | 20 | 40 | 20 |

#### Modifier Methods

```swift
LuxeButton("Action") { }
    .gradient([.red, .orange])
    .foregroundColor(.white)
    .shadowColor(.red)
    .cornerRadius(20)
    .fontSize(18)
```

---

### LuxeBadge

Small glowing label for status indicators and tags.

#### Initializers

```swift
LuxeBadge("NEW", color: .green)
LuxeBadge("PRO", color: .purple, configuration: .large)
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `fontSize` | `CGFloat` | `10` | Text size |
| `fontWeight` | `Font.Weight` | `.bold` | Text weight |
| `paddingHorizontal` | `CGFloat` | `12` | Horizontal padding |
| `paddingVertical` | `CGFloat` | `6` | Vertical padding |
| `cornerRadius` | `CGFloat` | `20` | Corner radius |
| `backgroundOpacity` | `Double` | `0.2` | Background opacity |
| `glowRadius` | `CGFloat` | `8` | Glow blur radius |
| `glowOpacity` | `Double` | `0.5` | Glow opacity |
| `enableGlow` | `Bool` | `true` | Show glow effect |

#### Presets

| Preset | Description |
|--------|-------------|
| `.default` | Standard with glow |
| `.small` | Compact size |
| `.large` | Prominent size |
| `.noGlow` | Without glow effect |

---

### GlassmorphismContainer

Container with frosted glass effect background.

#### Initializers

```swift
// With configuration
GlassmorphismContainer(configuration: .frosted) {
    // Content
}

// With parameters
GlassmorphismContainer(
    blurRadius: 25,
    opacity: 0.3,
    cornerRadius: 24
) {
    // Content
}
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `blurRadius` | `CGFloat` | `20` | Glass blur radius |
| `backgroundOpacity` | `Double` | `0.3` | Background opacity |
| `cornerRadius` | `CGFloat` | `20` | Corner radius |
| `borderWidth` | `CGFloat` | `1` | Border width |
| `borderOpacity` | `Double` | `0.2` | Border opacity |
| `gradientColors` | `[Color]` | White gradient | Overlay gradient |
| `shadowColor` | `Color` | `.black` | Shadow color |
| `shadowRadius` | `CGFloat` | `20` | Shadow blur |
| `shadowX` | `CGFloat` | `0` | Shadow X offset |
| `shadowY` | `CGFloat` | `10` | Shadow Y offset |
| `innerShadowOpacity` | `Double` | `0.1` | Inner shadow opacity |
| `enableInnerShadow` | `Bool` | `true` | Show inner shadow |
| `enableBorder` | `Bool` | `true` | Show border |

#### Presets

| Preset | Blur | Opacity | Description |
|--------|------|---------|-------------|
| `.default` | 20 | 0.3 | Balanced |
| `.frosted` | 30 | 0.4 | Heavy blur, opaque |
| `.clear` | 10 | 0.15 | Light, transparent |
| `.dark` | 25 | 0.5 | Dark-tinted |
| `.vibrant` | 15 | 0.25 | High contrast |
| `.minimal` | 8 | 0.1 | No borders/shadows |

#### Callbacks

```swift
GlassmorphismContainer { content }
    .onHoverStart { }
    .onHoverEnd { }
    .onTap { }
```

---

### CircularProgressBar

Animated circular progress indicator with gradient and glow effects.

#### Initializers

```swift
// Basic
CircularProgressBar(progress: 0.75)

// With configuration
CircularProgressBar(progress: 0.5, configuration: .neon)

// With parameters
CircularProgressBar(
    progress: 0.65,
    showPercentage: true,
    gradient: true,
    size: 120,
    lineWidth: 12,
    colors: [.green, .mint]
)

// Static size helpers
CircularProgressBar.small(progress: 0.5, showPercentage: false)
CircularProgressBar.medium(progress: 0.7)
CircularProgressBar.large(progress: 0.9, colors: [.orange, .red])
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `size` | `CGFloat` | `100` | Overall diameter |
| `lineWidth` | `CGFloat` | `10` | Stroke thickness |
| `lineCap` | `CGLineCap` | `.round` | Stroke cap style |
| `trackColor` | `Color` | `.gray` | Background track color |
| `trackOpacity` | `Double` | `0.2` | Track opacity |
| `progressColors` | `[Color]` | `[.blue, .purple]` | Progress gradient |
| `useGradient` | `Bool` | `true` | Use gradient coloring |
| `showPercentage` | `Bool` | `true` | Show center percentage |
| `percentageFontSize` | `CGFloat` | `24` | Percentage font size |
| `percentageFontWeight` | `Font.Weight` | `.bold` | Percentage weight |
| `percentageColor` | `Color` | `.white` | Percentage color |
| `animationDuration` | `Double` | `0.5` | Animation duration |
| `enableGlow` | `Bool` | `true` | Show glow effect |
| `glowRadius` | `CGFloat` | `8` | Glow blur radius |
| `glowOpacity` | `Double` | `0.5` | Glow opacity |
| `rotationOffset` | `Double` | `-90` | Start angle (top) |

#### Size Presets

| Preset | Size | Line Width | Font Size |
|--------|------|------------|-----------|
| `.small` | 50 | 6 | 12 |
| `.medium` | 80 | 8 | 18 |
| `.large` | 120 | 12 | 28 |
| `.extraLarge` | 160 | 14 | 36 |

#### Style Presets

| Preset | Description |
|--------|-------------|
| `.default` | Gradient with glow |
| `.flat` | No gradient or glow |
| `.neon` | Cyan/blue with strong glow |
| `.subtle` | Minimal track visibility |

#### Callbacks

```swift
CircularProgressBar(progress: value)
    .onProgressChange { newValue in
        print("Progress: \(newValue)")
    }
    .onComplete {
        print("100% reached!")
    }
```

---

### MultiThumbSlider

Range slider with multiple draggable thumbs.

#### Initializers

```swift
@State var range = [20.0, 80.0]

// Basic
MultiThumbSlider(values: $range, range: 0...100)

// With configuration
MultiThumbSlider(
    values: $range,
    range: 0...1000,
    step: 50,
    configuration: .vibrant
)

// With parameters
MultiThumbSlider(
    values: $range,
    range: 0...100,
    step: 5,
    showLabels: true,
    colors: [.green, .blue]
)
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trackHeight` | `CGFloat` | `6` | Track height |
| `thumbSize` | `CGFloat` | `24` | Thumb diameter |
| `trackColor` | `Color` | `.gray` | Inactive track color |
| `trackOpacity` | `Double` | `0.3` | Track opacity |
| `activeTrackColors` | `[Color]` | `[.blue, .purple]` | Active range gradient |
| `thumbColor` | `Color` | `.white` | Thumb fill color |
| `thumbBorderColor` | `Color` | `.blue` | Thumb border color |
| `thumbBorderWidth` | `CGFloat` | `2` | Thumb border width |
| `thumbShadowColor` | `Color` | `.black` | Thumb shadow color |
| `thumbShadowRadius` | `CGFloat` | `4` | Thumb shadow blur |
| `showLabels` | `Bool` | `true` | Show value labels |
| `labelFontSize` | `CGFloat` | `12` | Label font size |
| `labelColor` | `Color` | `.white` | Label color |
| `enableHaptics` | `Bool` | `true` | Enable haptics |
| `hapticOnChange` | `Bool` | `false` | Haptic on value change |
| `hapticOnBoundary` | `Bool` | `true` | Haptic at boundaries |

#### Presets

| Preset | Description |
|--------|-------------|
| `.default` | Balanced appearance |
| `.compact` | Smaller track/thumbs |
| `.large` | Touch-friendly size |
| `.minimal` | Thin track, no labels |
| `.vibrant` | Colorful gradient |

#### Callbacks

```swift
MultiThumbSlider(values: $range)
    .onValueChange { values in
        print("Range: \(values[0]) - \(values[1])")
    }
    .onDragStart { thumbIndex in
        print("Started dragging thumb \(thumbIndex)")
    }
    .onDragEnd { thumbIndex in
        print("Stopped dragging thumb \(thumbIndex)")
    }
```

---

### FloatingOrb

Animated glowing orb for atmospheric backgrounds.

#### Initializer

```swift
FloatingOrb(
    size: 200,
    color: .purple,
    configuration: .vibrant
)
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `blurRadius` | `CGFloat` | `60` | Orb blur radius |
| `opacity` | `Double` | `0.6` | Orb opacity |
| `animationDuration` | `Double` | `4` | Float cycle duration |
| `animationRange` | `CGFloat` | `20` | Float distance |
| `enableAnimation` | `Bool` | `true` | Enable floating |
| `enableGlow` | `Bool` | `true` | Enable glow effect |
| `glowRadius` | `CGFloat` | `50` | Glow shadow blur |

#### Presets

| Preset | Description |
|--------|-------------|
| `.default` | Standard animated orb |
| `.subtle` | Softer, minimal movement |
| `.vibrant` | Brighter, dynamic |
| `.static` | No animation |

---

### MeshGradientBackground

Animated mesh gradient with multiple color orbs.

#### Initializers

```swift
// Basic
MeshGradientBackground(colors: [.purple, .blue, .cyan])

// With configuration
MeshGradientBackground(
    colors: [.purple, .blue, .cyan],
    configuration: .vibrant
)

// With parameters
MeshGradientBackground(
    colors: [.red, .orange, .yellow],
    orbCount: 4,
    orbBlur: 120,
    orbOpacity: 0.8,
    animationDuration: 10,
    enableAnimation: true,
    backgroundColor: .black
)
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `orbCount` | `Int` | `3` | Number of orbs |
| `orbSizes` | `[CGFloat]` | `[400, 350, 300]` | Orb sizes |
| `orbOffsets` | `[(x, y)]` | Various | Orb positions |
| `orbBlur` | `CGFloat` | `100` | Orb blur radius |
| `orbOpacity` | `Double` | `0.7` | Orb opacity |
| `animationDuration` | `Double` | `8` | Animation cycle |
| `animationRange` | `CGFloat` | `50` | Movement distance |
| `enableAnimation` | `Bool` | `true` | Enable animation |
| `backgroundColor` | `Color` | Dark blue | Background color |

#### Presets

| Preset | Orbs | Description |
|--------|------|-------------|
| `.default` | 3 | Balanced animation |
| `.minimal` | 2 | Cleaner look |
| `.vibrant` | 5 | Dynamic movement |
| `.static` | 3 | No animation |

---

## View Modifiers

### .refractiveGlass()

LuxeUI's signature 2026 premium effect - simulates real optical glass with lens distortion and chromatic aberration.

```swift
Text("Premium Content")
    .padding()
    .refractiveGlass(configuration: .liquid)
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `distortionIntensity` | `Double` | `0.2` | Lens distortion (0-1) |
| `distortionRadius` | `CGFloat` | `50` | Distortion radius |
| `chromaticAberration` | `Bool` | `true` | Enable RGB split |
| `aberrationStrength` | `CGFloat` | `2.0` | RGB split strength |
| `causticAnimation` | `Bool` | `true` | Animated light patterns |
| `causticSpeed` | `Double` | `0.5` | Animation speed |
| `causticCount` | `Int` | `8` | Light point count |
| `layerCount` | `Int` | `3` | Glass layer depth |
| `blurRadius` | `CGFloat` | `20` | Glass blur |
| `cornerRadius` | `CGFloat` | `24` | Corner radius |
| `backgroundOpacity` | `Double` | `0.15` | Background opacity |
| `borderWidth` | `CGFloat` | `1.5` | Border width |
| `borderOpacity` | `Double` | `0.4` | Border opacity |
| `shadowRadius` | `CGFloat` | `30` | Shadow blur |
| `shadowOpacity` | `Double` | `0.5` | Shadow opacity |
| `enableHaptics` | `Bool` | `true` | Enable haptics |

#### Presets

| Preset | Description |
|--------|-------------|
| `.default` | Balanced effect |
| `.subtle` | Light, readable |
| `.intense` | Strong distortion |
| `.minimal` | Performance optimized |
| `.liquid` | Water-like effect |
| `.frosted` | Heavy blur, no distortion |

---

### .smartSprings()

Velocity-aware spring physics for drag gestures.

```swift
Image("card")
    .smartSprings(configuration: .bouncy)
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `sensitivity` | `Double` | `1.0` | Drag sensitivity |
| `enableRotation` | `Bool` | `false` | Rotate during drag |
| `rotationMultiplier` | `Double` | `1.0` | Rotation intensity |
| `maxOffset` | `CGFloat` | `100` | Maximum drag offset |
| `maxRotation` | `Double` | `15` | Maximum rotation degrees |
| `responseSpeed` | `Double` | `0.3` | Spring response |
| `dampingFraction` | `Double` | `0.7` | Spring damping |
| `velocityThreshold` | `CGFloat` | `500` | Haptic trigger velocity |
| `enableHaptics` | `Bool` | `true` | Enable haptics |
| `hapticIntensity` | `Intensity` | `.light` | Haptic strength |

#### Presets

| Preset | Description |
|--------|-------------|
| `.default` | Balanced physics |
| `.bouncy` | Playful, energetic |
| `.stiff` | Controlled, precise |
| `.wobbly` | Fun rotation effect |
| `.subtle` | Minimal movement |

---

### .magneticPull()

Magnetic attraction hover effect.

```swift
Button("Click Me") { }
    .magneticPull(configuration: .strong)
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `radius` | `CGFloat` | `100` | Detection radius |
| `strength` | `Double` | `0.5` | Pull strength (0-1) |
| `maxOffset` | `CGFloat` | `20` | Maximum movement |
| `responseSpeed` | `Double` | `0.3` | Spring response |
| `dampingFraction` | `Double` | `0.7` | Spring damping |
| `enableHaptics` | `Bool` | `true` | Enable haptics |
| `hapticOnEnter` | `Bool` | `true` | Haptic on enter |

#### Presets

| Preset | Description |
|--------|-------------|
| `.default` | Balanced attraction |
| `.strong` | Pronounced pull |
| `.subtle` | Gentle attraction |
| `.wide` | Large detection radius |

---

## Predictive Layouts

### LuxeAdaptiveContainer

Container that adapts appearance based on probability values (0.0-1.0).

```swift
LuxeAdaptiveContainer(probability: 0.8) {
    Button("Recommended Action") { }
}
    .glowColor(.green)
    .threshold(0.6)
```

#### Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `baseOpacity` | `Double` | `0.7` | Opacity at probability 0 |
| `activeOpacity` | `Double` | `1.0` | Opacity at probability 1 |
| `baseScale` | `CGFloat` | `1.0` | Scale at probability 0 |
| `activeScale` | `CGFloat` | `1.05` | Scale at probability 1 |
| `baseShadowRadius` | `CGFloat` | `5` | Shadow at probability 0 |
| `activeShadowRadius` | `CGFloat` | `20` | Shadow at probability 1 |
| `glowColor` | `Color` | `.blue` | Glow effect color |
| `glowOpacity` | `Double` | `0.3` | Glow opacity |
| `probabilityThreshold` | `Double` | `0.5` | Glow activation threshold |
| `enableGlow` | `Bool` | `true` | Enable glow |
| `enableScale` | `Bool` | `true` | Enable scale |
| `enableElevation` | `Bool` | `true` | Enable shadow |

#### Presets

| Preset | Description |
|--------|-------------|
| `.default` | Balanced effects |
| `.subtle` | Minimal changes |
| `.prominent` | Strong differentiation |
| `.noAnimation` | Instant transitions |

---

### SmartFormButton

Button that grows and changes color as form completion increases.

```swift
SmartFormButton(
    "Submit",
    completionProbability: formProgress,
    configuration: .large
) {
    submitForm()
}
```

---

## Utilities

### TactileFeedback

Cross-platform haptic feedback utility.

```swift
// Intensity levels
TactileFeedback.light()
TactileFeedback.medium()
TactileFeedback.heavy()

// Semantic feedback
TactileFeedback.success()
TactileFeedback.warning()
TactileFeedback.error()

// With enum
TactileFeedback.trigger(.medium)
```

#### Intensity Enum

```swift
public enum Intensity {
    case light
    case medium
    case heavy
}
```

---

## Platform Support

| Platform | Minimum Version |
|----------|-----------------|
| macOS | 12.0+ |
| iOS | 15.0+ |

---

## License

MIT License - see [LICENSE](../LICENSE) for details.
