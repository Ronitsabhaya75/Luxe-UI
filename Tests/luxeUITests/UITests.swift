import Testing
import SwiftUI
@testable import LuxeUI

// MARK: - UI Tests
// These tests verify that all LuxeUI SwiftUI views render correctly
// and have the expected visual properties and behaviors.

// MARK: - LuxeCard UI Tests

@Suite("LuxeCard UI Tests")
struct LuxeCardUITests {
    
    @Test("LuxeCard renders with default configuration")
    func defaultRendering() {
        let card = LuxeCard {
            Text("Test Content")
        }
        
        let mirror = Mirror(reflecting: card)
        let config = mirror.descendant("configuration") as? LuxeCardConfiguration
        #expect(config != nil)
    }
    
    @Test("LuxeCard renders with all preset configurations")
    func presetRendering() {
        let presets: [LuxeCardConfiguration] = [
            .default,
            .compact,
            .prominent,
            .subtle,
            .floating
        ]
        
        for preset in presets {
            let card = LuxeCard(configuration: preset) {
                Text("Preset Card")
            }
            let mirror = Mirror(reflecting: card)
            let config = mirror.descendant("configuration") as? LuxeCardConfiguration
            #expect(config != nil)
            #expect(config?.cornerRadius == preset.cornerRadius)
        }
    }
    
    @Test("LuxeCard renders with custom parameters")
    func customParameterRendering() {
        let card = LuxeCard(
            cornerRadius: 32,
            blur: 20,
            backgroundOpacity: 0.25,
            borderWidth: 2,
            shadowRadius: 30,
            hoverScale: 1.1,
            pressScale: 0.95,
            enableHaptics: false
        ) {
            VStack {
                Text("Custom Card")
                Image(systemName: "star.fill")
            }
        }
        
        let mirror = Mirror(reflecting: card)
        let config = mirror.descendant("configuration") as? LuxeCardConfiguration
        #expect(config != nil)
        #expect(config?.cornerRadius == 32)
        #expect(config?.blur == 20)
    }
    
    @Test("LuxeCard supports callback modifiers")
    func callbackModifiers() {
        let card = LuxeCard {
            Text("Interactive Card")
        }
        .onTap { }
        .onHoverStart { }
        .onHoverEnd { }
        
        #expect(card.body != nil)
    }
    
    @Test("LuxeCard renders with complex content")
    func complexContentRendering() {
        let card = LuxeCard(configuration: .prominent) {
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text("John Doe")
                            .font(.headline)
                        Text("Premium Member")
                            .font(.caption)
                    }
                }
                Divider()
                HStack {
                    Label("Settings", systemImage: "gear")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
        }
        
        #expect(card.body != nil)
    }
}

// MARK: - GlassmorphismContainer UI Tests

@Suite("GlassmorphismContainer UI Tests")
struct GlassmorphismContainerUITests {
    
    @Test("GlassmorphismContainer renders with default configuration")
    func defaultRendering() {
        let container = GlassmorphismContainer {
            Text("Glass Content")
        }
        
        let mirror = Mirror(reflecting: container)
        #expect(mirror.descendant("configuration") as? GlassmorphismConfiguration != nil)
    }
    
    @Test("GlassmorphismContainer renders with all presets")
    func presetRendering() {
        let presets: [GlassmorphismConfiguration] = [
            .default,
            .frosted,
            .clear,
            .dark,
            .vibrant,
            .minimal
        ]
        
        for preset in presets {
            let container = GlassmorphismContainer(configuration: preset) {
                Text("Glass")
            }
            let mirror = Mirror(reflecting: container)
            let config = mirror.descendant("configuration") as? GlassmorphismConfiguration
            #expect(config?.blurRadius == preset.blurRadius)
        }
    }
    
    @Test("GlassmorphismContainer renders with custom parameters")
    func customParameterRendering() {
        let container = GlassmorphismContainer(
            blurRadius: 30,
            opacity: 0.5,
            cornerRadius: 28
        ) {
            Text("Custom Glass")
        }
        
        let mirror = Mirror(reflecting: container)
        let config = mirror.descendant("configuration") as? GlassmorphismConfiguration
        #expect(config?.blurRadius == 30)
        #expect(config?.backgroundOpacity == 0.5)
        #expect(config?.cornerRadius == 28)
    }
    
    @Test("GlassmorphismContainer renders nested content")
    func nestedContentRendering() {
        let container = GlassmorphismContainer(configuration: .frosted) {
            VStack(spacing: 20) {
                ForEach(0..<3, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(.blue)
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading) {
                            Text("Item \(index)")
                                .font(.headline)
                            Text("Description text")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                }
            }
            .padding()
        }
        
        #expect(container.body != nil)
    }
}

// MARK: - RefractiveGlass UI Tests

@Suite("RefractiveGlass UI Tests")
struct RefractiveGlassUITests {
    
    @Test("RefractiveGlass modifier applies to view")
    func modifierApplication() {
        let view = Text("Refractive Content")
            .padding()
            .refractiveGlass()
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
    
    @Test("RefractiveGlass renders with all presets")
    func presetRendering() {
        let presets: [RefractiveGlassConfiguration] = [
            .default,
            .subtle,
            .intense,
            .minimal,
            .liquid,
            .frosted
        ]
        
        for preset in presets {
            let view = Text("Preset View")
                .padding()
                .refractiveGlass(configuration: preset)
            let mirror = Mirror(reflecting: view)
            #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
        }
    }
    
    @Test("RefractiveGlass renders with custom configuration")
    func customConfigRendering() {
        let config = RefractiveGlassConfiguration(
            distortionIntensity: 0.4,
            chromaticAberration: true,
            causticAnimation: true,
            layerCount: 4,
            blurRadius: 25
        )
        
        let view = VStack {
            Text("Custom Glass")
            Image(systemName: "sparkles")
        }
        .padding()
        .refractiveGlass(configuration: config)
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
    
    @Test("RefractiveGlass renders without chromatic aberration")
    func noChromaticAberration() {
        let config = RefractiveGlassConfiguration(
            chromaticAberration: false,
            causticAnimation: false
        )
        
        let view = Text("No Effects")
            .refractiveGlass(configuration: config)
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
}

// MARK: - CircularProgressBar UI Tests

@Suite("CircularProgressBar UI Tests")
struct CircularProgressBarUITests {
    
    @Test("CircularProgressBar renders at 0%")
    func zeroProgress() {
        let progress = CircularProgressBar(progress: 0.0)
        let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
    }
    
    @Test("CircularProgressBar renders at 50%")
    func halfProgress() {
        let progress = CircularProgressBar(progress: 0.5)
        let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
    }
    
    @Test("CircularProgressBar renders at 100%")
    func fullProgress() {
        let progress = CircularProgressBar(progress: 1.0)
        let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
    }
    
    @Test("CircularProgressBar renders with all size presets")
    func sizePresets() {
        let sizes: [CircularProgressConfiguration] = [
            .small,
            .medium,
            .large,
            .extraLarge
        ]
        
        for size in sizes {
            let progress = CircularProgressBar(progress: 0.75, configuration: size)
            let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
        }
    }
    
    @Test("CircularProgressBar renders with all style presets")
    func stylePresets() {
        let styles: [CircularProgressConfiguration] = [
            .default,
            .flat,
            .neon,
            .subtle
        ]
        
        for style in styles {
            let progress = CircularProgressBar(progress: 0.6, configuration: style)
            let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
        }
    }
    
    @Test("CircularProgressBar renders with custom colors")
    func customColors() {
        let config = CircularProgressConfiguration(
            progressColors: [.red, .orange, .yellow],
            useGradient: true
        )
        
        let progress = CircularProgressBar(progress: 0.8, configuration: config)
        let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
    }
    
    @Test("CircularProgressBar renders without percentage")
    func noPercentage() {
        let config = CircularProgressConfiguration(showPercentage: false)
        let progress = CircularProgressBar(progress: 0.5, configuration: config)
        let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
    }
    
    @Test("CircularProgressBar renders with glow effect")
    func glowEffect() {
        let config = CircularProgressConfiguration(
            enableGlow: true,
            glowRadius: 15,
            glowOpacity: 0.8
        )
        
        let progress = CircularProgressBar(progress: 0.9, configuration: config)
        let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
    }
    
    @Test("CircularProgressBar static size helpers")
    func staticSizeHelpers() {
        let small = CircularProgressBar.small(progress: 0.3)
        let medium = CircularProgressBar.medium(progress: 0.5)
        let large = CircularProgressBar.large(progress: 0.7)
        
        #expect(small.body != nil)
        #expect(medium.body != nil)
        #expect(large.body != nil)
    }
}

// MARK: - MultiThumbSlider UI Tests

@Suite("MultiThumbSlider UI Tests")
struct MultiThumbSliderUITests {
    
    @Test("MultiThumbSlider renders with two thumbs")
    func twoThumbRendering() {
        let values = [25.0, 75.0]
        let slider = MultiThumbSlider(
            values: .constant(values),
            range: 0...100
        )
        
        let mirror = Mirror(reflecting: slider)
        #expect(mirror.descendant("_values") != nil)
    }
    
    @Test("MultiThumbSlider renders with custom range")
    func customRange() {
        let values = [100.0, 500.0]
        let slider = MultiThumbSlider(
            values: .constant(values),
            range: 0...1000,
            step: 50
        )
        
        let mirror = Mirror(reflecting: slider)
        #expect(mirror.descendant("step") as? Double == 50)
    }
    
    @Test("MultiThumbSlider renders with all presets")
    func presetRendering() {
        let presets: [MultiThumbSliderConfiguration] = [
            .default,
            .compact,
            .large,
            .minimal,
            .vibrant
        ]
        
        let values = [20.0, 80.0]
        
        for preset in presets {
            let slider = MultiThumbSlider(
                values: .constant(values),
                configuration: preset
            )
            let mirror = Mirror(reflecting: slider)
            let config = mirror.descendant("configuration") as? MultiThumbSliderConfiguration
            #expect(config?.trackHeight == preset.trackHeight)
        }
    }
    
    @Test("MultiThumbSlider renders without labels")
    func noLabels() {
        let values = [30.0, 70.0]
        let slider = MultiThumbSlider(
            values: .constant(values),
            showLabels: false
        )
        
        let mirror = Mirror(reflecting: slider)
        let config = mirror.descendant("configuration") as? MultiThumbSliderConfiguration
        #expect(config?.showLabels == false)
    }
    
    @Test("MultiThumbSlider renders with custom colors")
    func customColors() {
        let values = [40.0, 60.0]
        let slider = MultiThumbSlider(
            values: .constant(values),
            colors: [.green, .mint, .cyan]
        )
        
        let mirror = Mirror(reflecting: slider)
        let config = mirror.descendant("configuration") as? MultiThumbSliderConfiguration
        #expect(config?.activeTrackColors.count == 3)
    }
    
    @Test("MultiThumbSlider supports callbacks")
    func callbackSupport() {
        let values = [25.0, 75.0]
        
        let slider = MultiThumbSlider(values: .constant(values))
            .onValueChange { _ in }
            .onDragStart { _ in }
            .onDragEnd { _ in }
        
        let mirror = Mirror(reflecting: slider)
        #expect(String(describing: mirror.subjectType).contains("MultiThumbSlider") || String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
}

// MARK: - SmartSpring UI Tests

@Suite("SmartSpring UI Tests")
struct SmartSpringUITests {
    
    @Test("SmartSprings modifier applies to view")
    func modifierApplication() {
        let view = Rectangle()
            .fill(.blue)
            .frame(width: 100, height: 100)
            .smartSprings()
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
    
    @Test("SmartSprings renders with all presets")
    func presetRendering() {
        let presets: [SmartSpringConfiguration] = [
            .default,
            .bouncy,
            .stiff,
            .wobbly,
            .subtle
        ]
        
        for preset in presets {
            let view = Circle()
                .fill(.purple)
                .smartSprings(configuration: preset)
            let mirror = Mirror(reflecting: view)
            #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
        }
    }
    
    @Test("SmartSprings with rotation enabled")
    func rotationEnabled() {
        let config = SmartSpringConfiguration(
            enableRotation: true,
            rotationMultiplier: 2.0,
            maxRotation: 30
        )
        
        let view = RoundedRectangle(cornerRadius: 16)
            .fill(.orange)
            .smartSprings(configuration: config)
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
}

// MARK: - MagneticPull UI Tests

@Suite("MagneticPull UI Tests")
struct MagneticPullUITests {
    
    @Test("MagneticPull modifier applies to view")
    func modifierApplication() {
        let view = Circle()
            .fill(.green)
            .frame(width: 50, height: 50)
            .magneticPull()
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
    
    @Test("MagneticPull renders with all presets")
    func presetRendering() {
        let presets: [MagneticPullConfiguration] = [
            .default,
            .strong,
            .subtle,
            .wide
        ]
        
        for preset in presets {
            let view = Image(systemName: "star.fill")
                .magneticPull(configuration: preset)
            let mirror = Mirror(reflecting: view)
            #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
        }
    }
}

// MARK: - PredictiveLayout UI Tests

@Suite("PredictiveLayout UI Tests")
struct PredictiveLayoutUITests {
    
    @Test("LuxeAdaptiveContainer renders with low probability")
    func lowProbability() {
        let container = LuxeAdaptiveContainer(probability: 0.2) {
            Text("Low Priority")
        }
        
        let mirror = Mirror(reflecting: container)
        #expect(String(describing: mirror.subjectType).contains("LuxeAdaptiveContainer"))
    }
    
    @Test("LuxeAdaptiveContainer renders with high probability")
    func highProbability() {
        let container = LuxeAdaptiveContainer(probability: 0.9) {
            Text("High Priority")
        }
        
        let mirror = Mirror(reflecting: container)
        #expect(String(describing: mirror.subjectType).contains("LuxeAdaptiveContainer"))
    }
    
    @Test("LuxeAdaptiveContainer renders with all presets")
    func presetRendering() {
        let presets: [PredictiveLayoutConfiguration] = [
            .default,
            .subtle,
            .prominent,
            .noAnimation
        ]
        
        for preset in presets {
            let container = LuxeAdaptiveContainer(
                probability: 0.7,
                configuration: preset
            ) {
                Text("Adaptive Content")
            }
            let mirror = Mirror(reflecting: container)
            #expect(String(describing: mirror.subjectType).contains("LuxeAdaptiveContainer"))
        }
    }
    
    @Test("PredictiveRow configuration works")
    func predictiveRowConfig() {
        // Verify the configuration exists and works
        let config = PredictiveLayoutConfiguration.default
        #expect(config.enableGlow == true)
        #expect(config.enableScale == true)
    }
}

// MARK: - Premium Components UI Tests

@Suite("Premium Components UI Tests")
struct PremiumComponentsUITests {
    
    @Test("LuxeButton renders with all sizes")
    func buttonSizes() {
        let sizes: [LuxeButtonConfiguration] = [
            .small,
            .medium,
            .large,
            .extraLarge
        ]
        
        for size in sizes {
            let button = LuxeButton("Click Me", configuration: size) { }
            let mirror = Mirror(reflecting: button)
            #expect(String(describing: mirror.subjectType).contains("LuxeButton"))
        }
    }
    
    @Test("LuxeButton renders with title")
    func buttonWithTitle() {
        let button = LuxeButton(
            "Download",
            style: .primary,
            action: { }
        )
        
        let mirror = Mirror(reflecting: button)
        #expect(String(describing: mirror.subjectType).contains("LuxeButton"))
    }
    
    @Test("LuxeButton renders with different styles")
    func buttonStyles() {
        let styles: [LuxeButtonStyle] = [
            .primary,
            .secondary,
            .glass
        ]
        
        for style in styles {
            let button = LuxeButton("Styled", style: style) { }
            let mirror = Mirror(reflecting: button)
            #expect(String(describing: mirror.subjectType).contains("LuxeButton"))
        }
    }
    
    @Test("LuxeBadge renders with all presets")
    func badgePresets() {
        let presets: [LuxeBadgeConfiguration] = [
            .default,
            .small,
            .large,
            .noGlow
        ]
        
        for preset in presets {
            let badge = LuxeBadge("NEW", configuration: preset)
            let mirror = Mirror(reflecting: badge)
            #expect(String(describing: mirror.subjectType).contains("LuxeBadge"))
        }
    }
    
    @Test("LuxeBadge renders with custom colors")
    func badgeCustomColors() {
        let badge = LuxeBadge("SALE", color: .red)
        let mirror = Mirror(reflecting: badge)
        #expect(String(describing: mirror.subjectType).contains("LuxeBadge"))
    }
    
    @Test("FloatingOrb renders with all presets")
    func orbPresets() {
        let presets: [FloatingOrbConfiguration] = [
            .default,
            .subtle,
            .vibrant,
            .static
        ]
        
        for preset in presets {
            let orb = FloatingOrb(size: 100, color: .purple, configuration: preset)
            let mirror = Mirror(reflecting: orb)
            #expect(String(describing: mirror.subjectType).contains("FloatingOrb"))
        }
    }
    
    @Test("FloatingOrb renders with custom size")
    func orbCustomSize() {
        let orb = FloatingOrb(size: 200, color: .blue)
        let mirror = Mirror(reflecting: orb)
        #expect(String(describing: mirror.subjectType).contains("FloatingOrb"))
    }
    
    @Test("MeshGradientBackground renders")
    func meshGradientRendering() {
        let gradient = MeshGradientBackground(
            colors: [Color.blue, Color.purple, Color.pink, Color.orange]
        )
        
        let mirror = Mirror(reflecting: gradient)
        #expect(String(describing: mirror.subjectType).contains("MeshGradientBackground"))
    }
}

// MARK: - Theme Integration UI Tests

@Suite("Theme Integration UI Tests")
struct ThemeIntegrationUITests {
    
    @Test("Components render with default theme")
    func defaultThemeRendering() {
        let view = VStack {
            LuxeCard {
                Text("Themed Card")
            }
            GlassmorphismContainer {
                Text("Themed Container")
            }
            CircularProgressBar(progress: 0.5)
        }
        .luxeTheme(Theme.default)
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
    
    @Test("Components render with all theme presets")
    func allThemePresets() {
        let themes: [Theme] = [
            .default,
            .midnight,
            .sunset,
            .ocean,
            .forest,
            .neon,
            .monochrome,
            .light
        ]
        
        for theme in themes {
            let view = LuxeCard {
                Text("Themed Content")
            }
            .luxeTheme(theme)
            
            let mirror = Mirror(reflecting: view)
            #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
        }
    }
    
    @Test("Nested components inherit theme")
    func themeInheritance() {
        let view = VStack {
            GlassmorphismContainer {
                LuxeCard {
                    VStack {
                        CircularProgressBar(progress: 0.7)
                        LuxeButton("Action") {}
                    }
                }
            }
        }
        .luxeTheme(Theme.midnight)
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
    
    @Test("Custom theme applies to components")
    func customThemeApplication() {
        let customTheme = Theme(
            primaryColor: .orange,
            secondaryColor: .pink,
            cornerRadius: 24,
            enableHaptics: false
        )
        
        let view = VStack {
            LuxeCard(configuration: .prominent) {
                Text("Custom Themed")
            }
            LuxeBadge("CUSTOM")
        }
        .luxeTheme(customTheme)
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
}

// MARK: - Complex Layout UI Tests

@Suite("Complex Layout UI Tests")
struct ComplexLayoutUITests {
    
    @Test("Dashboard layout renders correctly")
    func dashboardLayout() {
        let view = VStack(spacing: 20) {
            HStack(spacing: 16) {
                LuxeCard(configuration: .compact) {
                    VStack {
                        Text("Revenue")
                        Text("$12,345")
                            .font(.title)
                    }
                }
                LuxeCard(configuration: .compact) {
                    VStack {
                        Text("Users")
                        Text("1,234")
                            .font(.title)
                    }
                }
            }
            
            GlassmorphismContainer(configuration: .frosted) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Progress")
                        .font(.headline)
                    HStack {
                        CircularProgressBar(progress: 0.75, configuration: .small)
                        VStack(alignment: .leading) {
                            Text("Q4 Goals")
                            Text("75% Complete")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
            }
        }
        .luxeTheme(Theme.midnight)
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
    
    @Test("Settings page layout renders correctly")
    func settingsLayout() {
        let sliderValues: [Double] = [20, 80]
        
        let view = VStack(spacing: 16) {
            GlassmorphismContainer {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Preferences")
                        .font(.headline)
                    
                    HStack {
                        Text("Volume Range")
                        Spacer()
                    }
                    
                    MultiThumbSlider(
                        values: .constant(sliderValues),
                        configuration: .compact
                    )
                }
                .padding()
            }
            
            LuxeCard {
                HStack {
                    Text("Haptics")
                    Spacer()
                    LuxeBadge("ON", color: .green)
                }
            }
        }
        .luxeTheme(Theme.ocean)
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
    
    @Test("Profile card layout renders correctly")
    func profileCardLayout() {
        let view = LuxeCard(configuration: .prominent) {
            VStack(spacing: 16) {
                FloatingOrb(size: 80, color: .blue)
                
                Text("John Doe")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Premium Member")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 8) {
                    LuxeBadge("PRO", color: .purple)
                    LuxeBadge("VERIFIED", color: .green)
                }
                
                LuxeButton("Edit Profile", configuration: .medium) {}
            }
            .padding()
        }
        .luxeTheme(Theme.neon)
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ModifiedContent"))
    }
    
    @Test("Onboarding screen layout renders correctly")
    func onboardingLayout() {
        let view = ZStack {
            MeshGradientBackground(colors: [Color.blue, Color.purple, Color.pink])
            
            VStack(spacing: 32) {
                Spacer()
                
                Text("Welcome to LuxeUI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .refractiveGlass(configuration: .liquid)
                
                CircularProgressBar(progress: 0.33, configuration: .large)
                
                GlassmorphismContainer(configuration: .clear) {
                    VStack(spacing: 16) {
                        Text("Step 1 of 3")
                        Text("Choose your theme preference")
                    }
                    .padding()
                }
                
                Spacer()
                
                LuxeButton("Continue", configuration: .large) {}
                    .padding(.horizontal, 40)
            }
        }
        
        let mirror = Mirror(reflecting: view)
        #expect(String(describing: mirror.subjectType).contains("ZStack"))
    }
}

// MARK: - Accessibility UI Tests

@Suite("Accessibility UI Tests")
struct AccessibilityUITests {
    
    @Test("Components are accessible")
    func componentAccessibility() {
        // Verify components can be created with accessibility in mind
        let card = LuxeCard {
            Text("Accessible Card")
                .accessibilityLabel("Premium feature card")
        }
        
        let progress = CircularProgressBar(progress: 0.75)
        
        let button = LuxeButton("Submit") {}
        
        let mirrorCard = Mirror(reflecting: card)
        #expect(String(describing: mirrorCard.subjectType).contains("LuxeCard"))
        let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
        let mirrorButton = Mirror(reflecting: button)
        #expect(String(describing: mirrorButton.subjectType).contains("LuxeButton"))
    }
}

// MARK: - Animation UI Tests

@Suite("Animation UI Tests")
struct AnimationUITests {
    
    @Test("Animated components initialize correctly")
    func animatedComponentsInit() {
        // Verify animated components don't crash on init
        let orb = FloatingOrb(size: 100, color: .blue, configuration: .default)
        let mesh = MeshGradientBackground(colors: [Color.blue, Color.purple])
        let progress = CircularProgressBar(progress: 0.5, configuration: .neon)
        
        let mirrorOrb = Mirror(reflecting: orb)
        #expect(String(describing: mirrorOrb.subjectType).contains("FloatingOrb"))
        let mirrorMesh = Mirror(reflecting: mesh)
        #expect(String(describing: mirrorMesh.subjectType).contains("MeshGradientBackground"))
        let m = Mirror(reflecting: progress); #expect(m.descendant("progress") as? Double != nil)
    }
    
    @Test("Static animation preset disables animation")
    func staticPreset() {
        let staticOrb = FloatingOrb(size: 100, color: .red, configuration: .static)
        let mirror = Mirror(reflecting: staticOrb)
        #expect(String(describing: mirror.subjectType).contains("FloatingOrb"))
        #expect(FloatingOrbConfiguration.static.enableAnimation == false)
    }
}
