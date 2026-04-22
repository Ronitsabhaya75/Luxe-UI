import Testing
import SwiftUI
@testable import LuxeUI

// MARK: - LuxeToast Smoke Tests

@Suite("LuxeToast Smoke Tests")
struct LuxeToastSmokeTests {

    @Test("All LuxeToastConfiguration presets exist")
    func presets() {
        let presets: [LuxeToastConfiguration] = [
            .default,
            .compact,
            .prominent,
            .persistent,
            .subtle
        ]

        #expect(presets.count == 5)

        for preset in presets {
            #expect(preset.cornerRadius > 0)
            #expect(preset.blurRadius > 0)
            #expect(preset.animationResponse > 0)
            #expect(preset.animationDamping > 0)
        }
    }

    @Test("Default configuration has expected values")
    func defaultValues() {
        let config = LuxeToastConfiguration()

        #expect(config.cornerRadius == 16)
        #expect(config.blurRadius == 12)
        #expect(config.backgroundOpacity == 0.15)
        #expect(config.titleFontSize == 14)
        #expect(config.messageFontSize == 12)
        #expect(config.iconSize == 20)
        #expect(config.autoDismissDuration == 3.0)
        #expect(config.enableGlow == true)
        #expect(config.enableHaptics == true)
        #expect(config.enableSwipeToDismiss == true)
        #expect(config.maxWidth == 420)
    }

    @Test("Compact preset has smaller values")
    func compactPreset() {
        let config = LuxeToastConfiguration.compact

        #expect(config.cornerRadius == 12)
        #expect(config.titleFontSize == 12)
        #expect(config.iconSize == 16)
        #expect(config.autoDismissDuration == 2.0)
        #expect(config.maxWidth == 320)
    }

    @Test("Prominent preset has larger values")
    func prominentPreset() {
        let config = LuxeToastConfiguration.prominent

        #expect(config.cornerRadius == 20)
        #expect(config.titleFontSize == 16)
        #expect(config.iconSize == 24)
        #expect(config.autoDismissDuration == 5.0)
        #expect(config.glowRadius == 16)
    }

    @Test("Persistent preset has no auto-dismiss")
    func persistentPreset() {
        let config = LuxeToastConfiguration.persistent

        #expect(config.autoDismissDuration == nil)
        #expect(config.enableSwipeToDismiss == true)
    }

    @Test("Subtle preset disables glow")
    func subtlePreset() {
        let config = LuxeToastConfiguration.subtle

        #expect(config.enableGlow == false)
    }

    @Test("Custom configuration can be created")
    func customConfiguration() {
        let config = LuxeToastConfiguration(
            cornerRadius: 24,
            blurRadius: 20,
            backgroundOpacity: 0.3,
            titleFontSize: 18,
            autoDismissDuration: 10.0,
            enableGlow: false,
            enableHaptics: false,
            position: .bottom,
            enableSwipeToDismiss: false,
            maxWidth: 600
        )

        #expect(config.cornerRadius == 24)
        #expect(config.blurRadius == 20)
        #expect(config.backgroundOpacity == 0.3)
        #expect(config.titleFontSize == 18)
        #expect(config.autoDismissDuration == 10.0)
        #expect(config.enableGlow == false)
        #expect(config.enableHaptics == false)
        #expect(config.enableSwipeToDismiss == false)
        #expect(config.maxWidth == 600)
    }
}

// MARK: - Toast Style Tests

@Suite("LuxeToastStyle Tests")
struct LuxeToastStyleTests {

    @Test("All styles have icon names")
    func iconNames() {
        #expect(LuxeToastStyle.success.iconName == "checkmark.circle.fill")
        #expect(LuxeToastStyle.error.iconName == "xmark.circle.fill")
        #expect(LuxeToastStyle.warning.iconName == "exclamationmark.triangle.fill")
        #expect(LuxeToastStyle.info.iconName == "info.circle.fill")
    }

    @Test("Custom style uses provided icon")
    func customIcon() {
        let style = LuxeToastStyle.custom(icon: "star.fill", color: .yellow)
        #expect(style.iconName == "star.fill")
    }

    @Test("Styles resolve correct theme colors")
    func themeColors() {
        let theme = Theme.default

        let successColor = LuxeToastStyle.success.color(for: theme)
        let errorColor = LuxeToastStyle.error.color(for: theme)
        let warningColor = LuxeToastStyle.warning.color(for: theme)
        let infoColor = LuxeToastStyle.info.color(for: theme)

        #expect(successColor == theme.colors.success)
        #expect(errorColor == theme.colors.error)
        #expect(warningColor == theme.colors.warning)
        #expect(infoColor == theme.colors.info)
    }

    @Test("Custom style uses provided color")
    func customColor() {
        let style = LuxeToastStyle.custom(icon: "heart.fill", color: .pink)
        let theme = Theme.default

        #expect(style.color(for: theme) == .pink)
    }

    @Test("Custom style glow falls back to style color")
    func customGlowFallback() {
        let style = LuxeToastStyle.custom(icon: "star", color: .orange)
        let theme = Theme.default

        #expect(style.glowColor(for: theme) == .orange)
    }

    @Test("Custom style with explicit glow color")
    func customGlowExplicit() {
        let style = LuxeToastStyle.custom(icon: "star", color: .orange, glowColor: .red)
        let theme = Theme.default

        #expect(style.glowColor(for: theme) == .red)
    }

    @Test("Haptic methods do not crash")
    func haptics() {
        LuxeToastStyle.success.triggerHaptic()
        LuxeToastStyle.error.triggerHaptic()
        LuxeToastStyle.warning.triggerHaptic()
        LuxeToastStyle.info.triggerHaptic()
        LuxeToastStyle.custom(icon: "star", color: .yellow).triggerHaptic()

        #expect(true) // If we get here, no crash occurred
    }
}

// MARK: - Toast Position Tests

@Suite("LuxeToastPosition Tests")
struct LuxeToastPositionTests {

    @Test("Both positions can be used in configuration")
    func positionsInConfig() {
        let topConfig = LuxeToastConfiguration(position: .top)
        let bottomConfig = LuxeToastConfiguration(position: .bottom)

        // Verify they compile and can be stored — this is a type-safety check
        #expect(topConfig.cornerRadius > 0)
        #expect(bottomConfig.cornerRadius > 0)
    }
}

// MARK: - Toast Item Tests

@Suite("LuxeToastItem Tests")
struct LuxeToastItemTests {

    @Test("Toast item can be created with all parameters")
    func fullInit() {
        let item = LuxeToastItem(
            title: "Test Toast",
            message: "This is a test message",
            style: .success,
            configuration: .prominent
        )

        #expect(item.title == "Test Toast")
        #expect(item.message == "This is a test message")
        #expect(item.configuration.titleFontSize == 16)
    }

    @Test("Toast item has unique ID")
    func uniqueIDs() {
        let item1 = LuxeToastItem(title: "A")
        let item2 = LuxeToastItem(title: "B")

        #expect(item1.id != item2.id)
    }

    @Test("Toast item defaults to info style")
    func defaultStyle() {
        let item = LuxeToastItem(title: "Test")
        let theme = Theme.default

        #expect(item.style.iconName == "info.circle.fill")
        #expect(item.style.color(for: theme) == theme.colors.info)
    }

    @Test("Toast item message is optional")
    func optionalMessage() {
        let item = LuxeToastItem(title: "No message")
        #expect(item.message == nil)
    }
}

// MARK: - Toast Manager Tests

@Suite("LuxeToastManager Tests")
struct LuxeToastManagerTests {

    @MainActor
    @Test("Manager starts with empty toasts")
    func emptyStart() {
        let manager = LuxeToastManager()
        #expect(manager.toasts.isEmpty)
    }

    @MainActor
    @Test("Show adds toast to queue")
    func showAddsToast() {
        let manager = LuxeToastManager()

        manager.show("Test", style: .success, configuration: LuxeToastConfiguration(enableHaptics: false))

        #expect(manager.toasts.count == 1)
        #expect(manager.toasts[0].title == "Test")
    }

    @MainActor
    @Test("Show with message populates message field")
    func showWithMessage() {
        let manager = LuxeToastManager()

        manager.show("Title", message: "Message body", style: .error, configuration: LuxeToastConfiguration(enableHaptics: false))

        #expect(manager.toasts[0].message == "Message body")
    }

    @MainActor
    @Test("Multiple toasts are queued")
    func multipleToasts() {
        let manager = LuxeToastManager()
        let noHaptics = LuxeToastConfiguration(enableHaptics: false, position: .top)

        manager.show("First", style: .info, configuration: noHaptics)
        manager.show("Second", style: .success, configuration: noHaptics)
        manager.show("Third", style: .warning, configuration: noHaptics)

        #expect(manager.toasts.count == 3)
        #expect(manager.toasts[0].title == "First")
        #expect(manager.toasts[2].title == "Third")
    }

    @MainActor
    @Test("Dismiss removes specific toast")
    func dismissById() {
        let manager = LuxeToastManager()
        let noHaptics = LuxeToastConfiguration(enableHaptics: false)

        manager.show("Keep", style: .info, configuration: noHaptics)
        manager.show("Remove", style: .error, configuration: noHaptics)

        let removeId = manager.toasts[1].id
        manager.dismiss(removeId)

        #expect(manager.toasts.count == 1)
        #expect(manager.toasts[0].title == "Keep")
    }

    @MainActor
    @Test("DismissAll clears all toasts")
    func dismissAll() {
        let manager = LuxeToastManager()
        let noHaptics = LuxeToastConfiguration(enableHaptics: false)

        manager.show("A", configuration: noHaptics)
        manager.show("B", configuration: noHaptics)
        manager.show("C", configuration: noHaptics)

        manager.dismissAll()

        #expect(manager.toasts.isEmpty)
    }

    @MainActor
    @Test("Max visible toasts trims oldest")
    func maxVisibleToasts() {
        let manager = LuxeToastManager()
        manager.maxVisibleToasts = 2
        let noHaptics = LuxeToastConfiguration(enableHaptics: false, position: .top)

        manager.show("First", configuration: noHaptics)
        manager.show("Second", configuration: noHaptics)
        manager.show("Third", configuration: noHaptics)

        #expect(manager.toasts.count == 2)
        #expect(manager.toasts[0].title == "Second")
        #expect(manager.toasts[1].title == "Third")
    }

    @MainActor
    @Test("Default max visible is 3")
    func defaultMaxVisible() {
        let manager = LuxeToastManager()
        #expect(manager.maxVisibleToasts == 3)
    }
}

// MARK: - Toast View Integration Tests

@Suite("LuxeToast View Integration Tests")
struct LuxeToastViewIntegrationTests {

    @Test("Toast view can be instantiated")
    func viewInstantiation() {
        let item = LuxeToastItem(
            title: "Test",
            message: "Body",
            style: .success
        )

        let view = LuxeToastView(item: item) {}
        #expect(view != nil)
    }

    @Test("Toast modifier can be applied")
    func modifierApplication() {
        let view = Text("Hello")
            .luxeToast()
        #expect(view != nil)
    }

    @Test("Toast modifier with custom position")
    func modifierWithPosition() {
        let view = Text("Hello")
            .luxeToast(position: .bottom)
        #expect(view != nil)
    }

    @Test("Toast modifier with custom manager")
    func modifierWithManager() {
        let manager = LuxeToastManager()
        let view = Text("Hello")
            .luxeToast(manager: manager, position: .top)
        #expect(view != nil)
    }

    @Test("Toast integrates with theme")
    func themeIntegration() {
        let view = VStack {
            Text("Content")
        }
        .luxeTheme(.midnight)
        .luxeToast()

        #expect(view != nil)
    }

    @Test("Toast works alongside other LuxeUI components")
    func componentCoexistence() {
        let view = VStack {
            LuxeCard {
                Text("Card content")
            }
            LuxeButton("Action", style: .primary) {}
            LuxeBadge("NEW", color: .green)
        }
        .luxeTheme(.neon)
        .luxeToast()

        #expect(view != nil)
    }
}

// MARK: - Toast Configuration Combinations

@Suite("LuxeToast Configuration Combinations")
struct LuxeToastConfigCombinationTests {

    @Test("All styles work with all presets")
    func stylesWithPresets() {
        let styles: [LuxeToastStyle] = [
            .success, .error, .warning, .info,
            .custom(icon: "star", color: .yellow)
        ]
        let configs: [LuxeToastConfiguration] = [
            .default, .compact, .prominent, .persistent, .subtle
        ]

        for style in styles {
            for config in configs {
                let item = LuxeToastItem(
                    title: "Test",
                    style: style,
                    configuration: config
                )
                #expect(!item.title.isEmpty)
                #expect(item.configuration.cornerRadius > 0)
            }
        }
    }

    @Test("All styles work with all themes")
    func stylesWithThemes() {
        let styles: [LuxeToastStyle] = [
            .success, .error, .warning, .info
        ]
        let themes: [Theme] = [
            .default, .midnight, .sunset, .ocean,
            .forest, .neon, .monochrome, .light
        ]

        for style in styles {
            for theme in themes {
                let color = style.color(for: theme)
                let glow = style.glowColor(for: theme)
                #expect(color != nil)
                #expect(glow != nil)
            }
        }
    }
}
