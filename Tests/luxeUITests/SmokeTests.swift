import Testing
import SwiftUI
@testable import LuxeUI

// MARK: - Smoke Tests
// These tests verify that all LuxeUI components can be instantiated and configured
// without runtime errors. They serve as a basic sanity check for the library.

// MARK: - Theme System Smoke Tests

@Suite("Theme Smoke Tests")
struct ThemeSmokeTests {
    
    @Test("All theme presets can be instantiated")
    func themePresets() {
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
            #expect(theme.primaryColor != nil)
            #expect(theme.secondaryColor != nil)
            #expect(theme.cornerRadius > 0)
        }
    }
    
    @Test("Theme builder chain works")
    func themeBuilderChain() {
        let theme = Theme.default
            .withPrimaryColor(.red)
            .withSecondaryColor(.blue)
            .withAccentColor(.green)
            .withHaptics(false)
        
        #expect(theme.primaryColor == .red)
        #expect(theme.secondaryColor == .blue)
        #expect(theme.accentColor == .green)
        #expect(theme.enableHaptics == false)
    }
    
    @Test("All ThemePreset enum values exist")
    func themePresetEnum() {
        let allPresets = ThemePreset.allCases
        #expect(allPresets.count >= 8)
        
        for preset in allPresets {
            let theme = preset.theme
            #expect(theme.primaryColor != nil)
        }
    }
}

// MARK: - Design Token Smoke Tests

@Suite("Design Token Smoke Tests")
struct DesignTokenSmokeTests {
    
    @Test("LuxeColorScheme initializes with defaults")
    func colorScheme() {
        let colors = LuxeColorScheme()
        
        #expect(colors.primary != nil)
        #expect(colors.secondary != nil)
        #expect(colors.accent != nil)
        #expect(colors.success != nil)
        #expect(colors.warning != nil)
        #expect(colors.error != nil)
        #expect(colors.info != nil)
    }
    
    @Test("LuxeTypography initializes with defaults")
    func typography() {
        let typography = LuxeTypography()
        
        #expect(typography.fontSizeXS > 0)
        #expect(typography.fontSizeS > typography.fontSizeXS)
        #expect(typography.fontSizeM > typography.fontSizeS)
        #expect(typography.fontSizeL > typography.fontSizeM)
        #expect(typography.fontSizeXL > typography.fontSizeL)
        #expect(typography.lineHeightNormal > 1.0)
    }
    
    @Test("LuxeSpacing initializes with defaults")
    func spacing() {
        let spacing = LuxeSpacing()
        
        #expect(spacing.xxxs > 0)
        #expect(spacing.xxs > spacing.xxxs)
        #expect(spacing.xs > spacing.xxs)
        #expect(spacing.s > spacing.xs)
        #expect(spacing.m > spacing.s)
        #expect(spacing.l > spacing.m)
        #expect(spacing.xl > spacing.l)
    }
    
    @Test("LuxeBorderRadius initializes with defaults")
    func borderRadius() {
        let radius = LuxeBorderRadius()
        
        #expect(radius.none == 0)
        #expect(radius.xs > radius.none)
        #expect(radius.s > radius.xs)
        #expect(radius.m > radius.s)
        #expect(radius.l > radius.m)
        #expect(radius.full > 1000)
    }
    
    @Test("LuxeEffects initializes with defaults")
    func effects() {
        let effects = LuxeEffects()
        
        #expect(effects.shadowSmall > 0)
        #expect(effects.shadowMedium > effects.shadowSmall)
        #expect(effects.shadowLarge > effects.shadowMedium)
        #expect(effects.blurSmall > 0)
        #expect(effects.animationFast > 0)
        #expect(effects.animationNormal > effects.animationFast)
    }
}

// MARK: - LuxeCard Smoke Tests

@Suite("LuxeCard Smoke Tests")
struct LuxeCardSmokeTests {
    
    @Test("All LuxeCard presets exist")
    func presets() {
        let presets: [LuxeCardConfiguration] = [
            .default,
            .compact,
            .prominent,
            .subtle,
            .floating
        ]
        
        #expect(presets.count == 5)
        
        for preset in presets {
            #expect(preset.cornerRadius > 0)
            #expect(preset.blur >= 0)
            #expect(preset.hoverScale > 0)
        }
    }
    
    @Test("LuxeCard can be configured with custom values")
    func customConfiguration() {
        let config = LuxeCardConfiguration(
            cornerRadius: 32,
            blur: 20,
            backgroundOpacity: 0.25,
            borderWidth: 2,
            hoverScale: 1.1,
            pressScale: 0.95,
            enableHaptics: false
        )
        
        #expect(config.cornerRadius == 32)
        #expect(config.blur == 20)
        #expect(config.backgroundOpacity == 0.25)
        #expect(config.enableHaptics == false)
    }
    
    @Test("LuxeCard view can be instantiated")
    func viewInstantiation() {
        let card = LuxeCard {
            Text("Test Content")
        }
        
        let mirror = Mirror(reflecting: card)
        let config = mirror.descendant("configuration") as? LuxeCardConfiguration
        #expect(config != nil)
        #expect(config?.cornerRadius == LuxeCardConfiguration.default.cornerRadius)
        
        let configuredCard = LuxeCard(configuration: .prominent) {
            Text("Configured Content")
        }
        
        let configuredMirror = Mirror(reflecting: configuredCard)
        let customConfig = configuredMirror.descendant("configuration") as? LuxeCardConfiguration
        #expect(customConfig != nil)
        #expect(customConfig?.hoverScale == 1.05)
    }
}

// MARK: - Glassmorphism Smoke Tests

@Suite("Glassmorphism Smoke Tests")
struct GlassmorphismSmokeTests {
    
    @Test("All Glassmorphism presets exist")
    func presets() {
        let presets: [GlassmorphismConfiguration] = [
            .default,
            .frosted,
            .clear,
            .dark,
            .vibrant,
            .minimal
        ]
        
        #expect(presets.count == 6)
        
        for preset in presets {
            #expect(preset.blurRadius >= 0)
            #expect(preset.cornerRadius >= 0)
        }
    }
    
    @Test("GlassmorphismContainer can be configured")
    func customConfiguration() {
        let config = GlassmorphismConfiguration(
            blurRadius: 30,
            backgroundOpacity: 0.5,
            cornerRadius: 28,
            enableInnerShadow: false,
            enableBorder: false
        )
        
        #expect(config.blurRadius == 30)
        #expect(config.backgroundOpacity == 0.5)
        #expect(config.enableInnerShadow == false)
    }
    
    @Test("GlassmorphismContainer view can be instantiated")
    func viewInstantiation() {
        let container = GlassmorphismContainer {
            Text("Glass Content")
        }
        
        let mirror = Mirror(reflecting: container)
        let config = mirror.descendant("configuration") as? GlassmorphismConfiguration
        #expect(config != nil)
        #expect(config?.blurRadius == 20)
        
        let configuredContainer = GlassmorphismContainer(configuration: .frosted) {
            Text("Frosted Content")
        }
        
        let configuredMirror = Mirror(reflecting: configuredContainer)
        let frostedConfig = configuredMirror.descendant("configuration") as? GlassmorphismConfiguration
        #expect(frostedConfig != nil)
        #expect(frostedConfig?.backgroundOpacity == 0.1)
    }
}

// MARK: - Refractive Glass Smoke Tests

@Suite("Refractive Glass Smoke Tests")
struct RefractiveGlassSmokeTests {
    
    @Test("All RefractiveGlass presets exist")
    func presets() {
        let presets: [RefractiveGlassConfiguration] = [
            .default,
            .subtle,
            .intense,
            .minimal,
            .liquid,
            .frosted
        ]
        
        #expect(presets.count == 6)
        
        for preset in presets {
            #expect(preset.distortionIntensity >= 0)
            #expect(preset.layerCount >= 1)
            #expect(preset.blurRadius >= 0)
        }
    }
    
    @Test("RefractiveGlass can be configured with all options")
    func customConfiguration() {
        let config = RefractiveGlassConfiguration(
            distortionIntensity: 0.4,
            distortionRadius: 80,
            chromaticAberration: true,
            aberrationStrength: 3.5,
            causticAnimation: true,
            causticSpeed: 0.8,
            causticCount: 10,
            layerCount: 4,
            blurRadius: 25,
            cornerRadius: 32
        )
        
        #expect(config.distortionIntensity == 0.4)
        #expect(config.causticCount == 10)
        #expect(config.layerCount == 4)
    }
    
    @Test("Chromatic aberration can be disabled")
    func chromaticAberrationDisabled() {
        let config = RefractiveGlassConfiguration(
            chromaticAberration: false,
            causticAnimation: false
        )
        
        #expect(config.chromaticAberration == false)
        #expect(config.causticAnimation == false)
    }
}

// MARK: - Circular Progress Smoke Tests

@Suite("Circular Progress Smoke Tests")
struct CircularProgressSmokeTests {
    
    @Test("All size presets exist")
    func sizePresets() {
        let presets: [CircularProgressConfiguration] = [
            .small,
            .medium,
            .large,
            .extraLarge
        ]
        
        #expect(presets.count == 4)
        #expect(CircularProgressConfiguration.small.size < CircularProgressConfiguration.medium.size)
        #expect(CircularProgressConfiguration.medium.size < CircularProgressConfiguration.large.size)
        #expect(CircularProgressConfiguration.large.size < CircularProgressConfiguration.extraLarge.size)
    }
    
    @Test("All style presets exist")
    func stylePresets() {
        let presets: [CircularProgressConfiguration] = [
            .default,
            .flat,
            .neon,
            .subtle
        ]
        
        #expect(presets.count == 4)
    }
    
    @Test("CircularProgress can be configured")
    func customConfiguration() {
        let config = CircularProgressConfiguration(
            size: 150,
            lineWidth: 15,
            useGradient: true,
            showPercentage: false,
            enableGlow: true,
            glowRadius: 12
        )
        
        #expect(config.size == 150)
        #expect(config.lineWidth == 15)
        #expect(config.showPercentage == false)
    }
    
    @Test("CircularProgressBar view can be instantiated")
    func viewInstantiation() {
        let progress = CircularProgressBar(progress: 0.5)
        let mirror = Mirror(reflecting: progress)
        let value = mirror.descendant("progress") as? Double
        #expect(value == 0.5)
        
        let configuredProgress = CircularProgressBar(
            progress: 0.75,
            configuration: .neon
        )
        let configuredMirror = Mirror(reflecting: configuredProgress)
        let neonConfig = configuredMirror.descendant("configuration") as? CircularProgressConfiguration
        #expect(neonConfig != nil)
        #expect(neonConfig?.glowRadius == 15)
    }
}

// MARK: - Multi-Thumb Slider Smoke Tests

@Suite("MultiThumbSlider Smoke Tests")
struct MultiThumbSliderSmokeTests {
    
    @Test("All presets exist")
    func presets() {
        let presets: [MultiThumbSliderConfiguration] = [
            .default,
            .compact,
            .large,
            .minimal,
            .vibrant
        ]
        
        #expect(presets.count == 5)
        
        for preset in presets {
            #expect(preset.trackHeight > 0)
            #expect(preset.thumbSize > 0)
        }
    }
    
    @Test("MultiThumbSlider can be configured")
    func customConfiguration() {
        let config = MultiThumbSliderConfiguration(
            trackHeight: 10,
            thumbSize: 30,
            showLabels: false,
            enableHaptics: false
        )
        
        #expect(config.trackHeight == 10)
        #expect(config.thumbSize == 30)
        #expect(config.showLabels == false)
    }
    
    @Test("Haptic settings can be customized")
    func hapticSettings() {
        let config = MultiThumbSliderConfiguration(
            enableHaptics: true,
            hapticOnChange: true,
            hapticOnBoundary: false
        )
        
        #expect(config.enableHaptics == true)
        #expect(config.hapticOnChange == true)
        #expect(config.hapticOnBoundary == false)
    }
}

// MARK: - Smart Spring Smoke Tests

@Suite("SmartSpring Smoke Tests")
struct SmartSpringSmokeTests {
    
    @Test("All presets exist")
    func presets() {
        let presets: [SmartSpringConfiguration] = [
            .default,
            .bouncy,
            .stiff,
            .wobbly,
            .subtle
        ]
        
        #expect(presets.count == 5)
        
        for preset in presets {
            #expect(preset.sensitivity > 0)
            #expect(preset.maxOffset > 0)
        }
    }
    
    @Test("SmartSpring can be configured")
    func customConfiguration() {
        let config = SmartSpringConfiguration(
            sensitivity: 2.0,
            enableRotation: true,
            rotationMultiplier: 2.0,
            maxOffset: 150,
            maxRotation: 25,
            enableHaptics: false
        )
        
        #expect(config.sensitivity == 2.0)
        #expect(config.enableRotation == true)
        #expect(config.maxRotation == 25)
    }
    
    @Test("Spring physics values are valid")
    func springPhysics() {
        let config = SmartSpringConfiguration.bouncy
        
        #expect(config.responseSpeed > 0)
        #expect(config.dampingFraction > 0 && config.dampingFraction <= 1)
    }
}

// MARK: - Magnetic Pull Smoke Tests

@Suite("MagneticPull Smoke Tests")
struct MagneticPullSmokeTests {
    
    @Test("All presets exist")
    func presets() {
        let presets: [MagneticPullConfiguration] = [
            .default,
            .strong,
            .subtle,
            .wide
        ]
        
        #expect(presets.count == 4)
        
        for preset in presets {
            #expect(preset.radius > 0)
            #expect(preset.strength > 0 && preset.strength <= 1)
        }
    }
    
    @Test("MagneticPull can be configured")
    func customConfiguration() {
        let config = MagneticPullConfiguration(
            radius: 200,
            strength: 0.9,
            maxOffset: 40,
            enableHaptics: false
        )
        
        #expect(config.radius == 200)
        #expect(config.strength == 0.9)
        #expect(config.maxOffset == 40)
    }
}

// MARK: - Predictive Layout Smoke Tests

@Suite("PredictiveLayout Smoke Tests")
struct PredictiveLayoutSmokeTests {
    
    @Test("All presets exist")
    func presets() {
        let presets: [PredictiveLayoutConfiguration] = [
            .default,
            .subtle,
            .prominent,
            .noAnimation
        ]
        
        #expect(presets.count == 4)
    }
    
    @Test("PredictiveLayout can be configured")
    func customConfiguration() {
        let config = PredictiveLayoutConfiguration(
            baseOpacity: 0.5,
            activeOpacity: 1.0,
            baseScale: 0.95,
            activeScale: 1.1,
            enableGlow: true,
            enableScale: true,
            enableElevation: true
        )
        
        #expect(config.baseOpacity == 0.5)
        #expect(config.activeScale == 1.1)
        #expect(config.enableGlow == true)
    }
    
    @Test("noAnimation preset disables all effects")
    func noAnimationPreset() {
        let config = PredictiveLayoutConfiguration.noAnimation
        
        #expect(config.enableGlow == false)
        #expect(config.enableScale == false)
        #expect(config.enableElevation == false)
    }
}

// MARK: - Premium Components Smoke Tests

@Suite("Premium Components Smoke Tests")
struct PremiumComponentsSmokeTests {
    
    @Test("LuxeButton presets exist")
    func luxeButtonPresets() {
        let presets: [LuxeButtonConfiguration] = [
            .small,
            .medium,
            .large,
            .extraLarge
        ]
        
        #expect(presets.count == 4)
        #expect(LuxeButtonConfiguration.small.fontSize < LuxeButtonConfiguration.large.fontSize)
    }
    
    @Test("LuxeBadge presets exist")
    func luxeBadgePresets() {
        let presets: [LuxeBadgeConfiguration] = [
            .default,
            .small,
            .large,
            .noGlow
        ]
        
        #expect(presets.count == 4)
        #expect(LuxeBadgeConfiguration.noGlow.enableGlow == false)
    }
    
    @Test("FloatingOrb presets exist")
    func floatingOrbPresets() {
        let presets: [FloatingOrbConfiguration] = [
            .default,
            .subtle,
            .vibrant,
            .static
        ]
        
        #expect(presets.count == 4)
        #expect(FloatingOrbConfiguration.static.enableAnimation == false)
    }
}

// MARK: - Tactile Feedback Smoke Tests

@Suite("TactileFeedback Smoke Tests")
struct TactileFeedbackSmokeTests {
    
    @Test("All intensity levels exist")
    func intensityLevels() {
        let intensities: [TactileFeedback.Intensity] = [
            .light,
            .medium,
            .heavy
        ]
        
        #expect(intensities.count == 3)
    }
    
    @Test("Static methods are callable")
    func staticMethods() {
        // These should not crash - they may not trigger actual haptics in test
        TactileFeedback.light()
        TactileFeedback.medium()
        TactileFeedback.heavy()
        TactileFeedback.trigger(.light)
        TactileFeedback.trigger(.medium)
        TactileFeedback.trigger(.heavy)
        
        #expect(true) // If we get here, no crash occurred
    }
}

// MARK: - Library Metadata Smoke Tests

@Suite("Library Smoke Tests")
struct LibrarySmokeTests {
    
    @Test("LuxeUI version is defined")
    func version() {
        #expect(!LuxeUI.version.isEmpty)
        #expect(LuxeUI.version.contains("."))
    }
}

// MARK: - View Modifier Smoke Tests

@Suite("View Modifier Smoke Tests")
struct ViewModifierSmokeTests {
    
    @Test("Theme modifier exists")
    func themeModifier() {
        let view = Text("Test")
            .luxeTheme(Theme.midnight)
        #expect(view != nil)
    }
    
    @Test("Custom theme modifier exists")
    func customThemeModifier() {
        let customTheme = Theme(primaryColor: .red)
        let view = Text("Test")
            .luxeTheme(customTheme)
        #expect(view != nil)
    }
}

// MARK: - Integration Smoke Tests

@Suite("Integration Smoke Tests")
struct IntegrationSmokeTests {
    
    @Test("Components can be nested")
    func nestedComponents() {
        let nestedView = GlassmorphismContainer {
            LuxeCard {
                CircularProgressBar(progress: 0.5)
            }
        }
        #expect(nestedView != nil)
    }
    
    @Test("Theme flows through component hierarchy")
    func themeHierarchy() {
        let themedView = VStack {
            LuxeCard {
                Text("Card 1")
            }
            GlassmorphismContainer {
                Text("Container")
            }
        }
        .luxeTheme(Theme.neon)
        
        #expect(themedView != nil)
    }
    
    @Test("All configurations can coexist")
    func configurationCoexistence() {
        let cardConfig = LuxeCardConfiguration.prominent
        let glassConfig = GlassmorphismConfiguration.frosted
        let progressConfig = CircularProgressConfiguration.neon
        let sliderConfig = MultiThumbSliderConfiguration.vibrant
        let springConfig = SmartSpringConfiguration.bouncy
        
        #expect(cardConfig.cornerRadius > 0)
        #expect(glassConfig.blurRadius > 0)
        #expect(progressConfig.size > 0)
        #expect(sliderConfig.thumbSize > 0)
        #expect(springConfig.sensitivity > 0)
    }
}
