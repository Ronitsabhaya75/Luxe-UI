import SwiftUI

// MARK: - Toast Style

/// The visual style of a LuxeToast notification.
///
/// Each style maps to semantic colors from the active `LuxeColorScheme`,
/// ensuring consistent meaning across themes.
///
/// ## Styles
/// - `success`: Positive confirmation (e.g., "Saved!", "Done!")
/// - `error`: Failure or destructive result (e.g., "Upload failed")
/// - `warning`: Caution or non-blocking issue (e.g., "Low battery")
/// - `info`: Neutral informational message (e.g., "New update available")
/// - `custom`: User-defined icon, color, and optional glow
public enum LuxeToastStyle: Sendable {
    /// Positive confirmation with checkmark icon
    case success
    /// Failure or destructive result with X icon
    case error
    /// Caution or non-blocking issue with exclamation icon
    case warning
    /// Neutral informational message with info icon
    case info
    /// Custom styling with user-defined parameters
    case custom(icon: String, color: Color, glowColor: Color? = nil)

    /// The SF Symbol name for this style.
    var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .info: return "info.circle.fill"
        case .custom(let icon, _, _): return icon
        }
    }

    /// Resolve the style color from the current theme.
    func color(for theme: Theme) -> Color {
        switch self {
        case .success: return theme.colors.success
        case .error: return theme.colors.error
        case .warning: return theme.colors.warning
        case .info: return theme.colors.info
        case .custom(_, let color, _): return color
        }
    }

    /// Resolve the glow color (falls back to the style color).
    func glowColor(for theme: Theme) -> Color {
        switch self {
        case .custom(_, _, let glow): return glow ?? color(for: theme)
        default: return color(for: theme)
        }
    }

    /// Trigger the appropriate haptic for this style.
    func triggerHaptic() {
        switch self {
        case .success: TactileFeedback.success()
        case .error: TactileFeedback.error()
        case .warning: TactileFeedback.warning()
        case .info: TactileFeedback.light()
        case .custom: TactileFeedback.light()
        }
    }
}

// MARK: - Toast Position

/// Determines where toasts appear on screen.
///
/// ## Positions
/// - `top`: Slides in from the top edge
/// - `bottom`: Slides in from the bottom edge
public enum LuxeToastPosition: Sendable {
    /// Toast appears at the top of the screen
    case top
    /// Toast appears at the bottom of the screen
    case bottom
}

// MARK: - Toast Configuration

/// Configuration options for LuxeToast appearance and behavior.
///
/// `LuxeToastConfiguration` controls the visual styling, animation timing,
/// and interaction behavior of toast notifications. Use presets for quick
/// setup or customize individual properties.
///
/// ## Presets
/// - `default`: Balanced glassmorphic toast with 3s auto-dismiss
/// - `compact`: Smaller padding and font, shorter duration (2s)
/// - `prominent`: Larger text, stronger glow, longer duration (5s)
/// - `persistent`: No auto-dismiss, must be swiped away
/// - `subtle`: Minimal styling with no glow effect
///
/// ## Example
/// ```swift
/// // Using a preset
/// toast.show("Saved!", style: .success, configuration: .prominent)
///
/// // Custom configuration
/// let config = LuxeToastConfiguration(
///     cornerRadius: 24,
///     autoDismissDuration: 4.0,
///     enableGlow: true,
///     position: .bottom
/// )
/// toast.show("Custom", style: .info, configuration: config)
/// ```
public struct LuxeToastConfiguration: Sendable {
    /// The corner radius of the toast. Default: 16
    public var cornerRadius: CGFloat
    /// The blur radius for the glass background. Default: 12
    public var blurRadius: CGFloat
    /// The opacity of the background fill. Default: 0.15
    public var backgroundOpacity: Double
    /// The width of the border stroke. Default: 1
    public var borderWidth: CGFloat
    /// The opacity of the border gradient. Default: 0.25
    public var borderOpacity: Double
    /// The horizontal padding inside the toast. Default: 16
    public var paddingHorizontal: CGFloat
    /// The vertical padding inside the toast. Default: 12
    public var paddingVertical: CGFloat
    /// The font size of the title text. Default: 14
    public var titleFontSize: CGFloat
    /// The font weight of the title text. Default: .semibold
    public var titleFontWeight: Font.Weight
    /// The font size of the message text. Default: 12
    public var messageFontSize: CGFloat
    /// The size of the leading icon. Default: 20
    public var iconSize: CGFloat
    /// How long the toast stays visible in seconds. Nil = no auto-dismiss. Default: 3.0
    public var autoDismissDuration: Double?
    /// The spring animation response time. Default: 0.4
    public var animationResponse: Double
    /// The spring animation damping fraction. Default: 0.75
    public var animationDamping: Double
    /// Whether to show a glow effect matching the style color. Default: true
    public var enableGlow: Bool
    /// The blur radius of the glow shadow. Default: 10
    public var glowRadius: CGFloat
    /// The opacity of the glow shadow. Default: 0.4
    public var glowOpacity: Double
    /// Whether to trigger haptic feedback when the toast appears. Default: true
    public var enableHaptics: Bool
    /// Where the toast appears on screen. Default: .top
    public var position: LuxeToastPosition
    /// Whether the user can swipe to dismiss. Default: true
    public var enableSwipeToDismiss: Bool
    /// The shadow blur radius of the toast. Default: 15
    public var shadowRadius: CGFloat
    /// The vertical shadow offset. Default: 5
    public var shadowY: CGFloat
    /// The maximum width of the toast. Nil = no constraint. Default: 420
    public var maxWidth: CGFloat?

    public init(
        cornerRadius: CGFloat = 16,
        blurRadius: CGFloat = 12,
        backgroundOpacity: Double = 0.15,
        borderWidth: CGFloat = 1,
        borderOpacity: Double = 0.25,
        paddingHorizontal: CGFloat = 16,
        paddingVertical: CGFloat = 12,
        titleFontSize: CGFloat = 14,
        titleFontWeight: Font.Weight = .semibold,
        messageFontSize: CGFloat = 12,
        iconSize: CGFloat = 20,
        autoDismissDuration: Double? = 3.0,
        animationResponse: Double = 0.4,
        animationDamping: Double = 0.75,
        enableGlow: Bool = true,
        glowRadius: CGFloat = 10,
        glowOpacity: Double = 0.4,
        enableHaptics: Bool = true,
        position: LuxeToastPosition = .top,
        enableSwipeToDismiss: Bool = true,
        shadowRadius: CGFloat = 15,
        shadowY: CGFloat = 5,
        maxWidth: CGFloat? = 420
    ) {
        self.cornerRadius = cornerRadius
        self.blurRadius = blurRadius
        self.backgroundOpacity = backgroundOpacity
        self.borderWidth = borderWidth
        self.borderOpacity = borderOpacity
        self.paddingHorizontal = paddingHorizontal
        self.paddingVertical = paddingVertical
        self.titleFontSize = titleFontSize
        self.titleFontWeight = titleFontWeight
        self.messageFontSize = messageFontSize
        self.iconSize = iconSize
        self.autoDismissDuration = autoDismissDuration
        self.animationResponse = animationResponse
        self.animationDamping = animationDamping
        self.enableGlow = enableGlow
        self.glowRadius = glowRadius
        self.glowOpacity = glowOpacity
        self.enableHaptics = enableHaptics
        self.position = position
        self.enableSwipeToDismiss = enableSwipeToDismiss
        self.shadowRadius = shadowRadius
        self.shadowY = shadowY
        self.maxWidth = maxWidth
    }

    // MARK: - Presets

    /// Balanced glassmorphic toast with 3s auto-dismiss
    public static let `default` = LuxeToastConfiguration()

    /// Smaller padding and font, shorter duration (2s)
    public static let compact = LuxeToastConfiguration(
        cornerRadius: 12,
        paddingHorizontal: 12,
        paddingVertical: 8,
        titleFontSize: 12,
        messageFontSize: 10,
        iconSize: 16,
        autoDismissDuration: 2.0,
        glowRadius: 6,
        maxWidth: 320
    )

    /// Larger text, stronger glow, longer duration (5s)
    public static let prominent = LuxeToastConfiguration(
        cornerRadius: 20,
        blurRadius: 16,
        backgroundOpacity: 0.2,
        paddingHorizontal: 20,
        paddingVertical: 16,
        titleFontSize: 16,
        titleFontWeight: .bold,
        messageFontSize: 14,
        iconSize: 24,
        autoDismissDuration: 5.0,
        enableGlow: true,
        glowRadius: 16,
        glowOpacity: 0.6,
        shadowRadius: 20,
        maxWidth: 480
    )

    /// No auto-dismiss, must be swiped away
    public static let persistent = LuxeToastConfiguration(
        autoDismissDuration: nil,
        enableSwipeToDismiss: true
    )

    /// Minimal styling with no glow effect
    public static let subtle = LuxeToastConfiguration(
        cornerRadius: 12,
        blurRadius: 8,
        backgroundOpacity: 0.1,
        borderOpacity: 0.15,
        titleFontSize: 13,
        autoDismissDuration: 2.5,
        enableGlow: false,
        shadowRadius: 8,
        shadowY: 3
    )
}

// MARK: - Toast Item

/// An individual toast notification in the queue.
///
/// Each `LuxeToastItem` is a unique, identifiable entry managed by `LuxeToastManager`.
/// You typically don't create these directly — use `LuxeToastManager.show(...)` instead.
public struct LuxeToastItem: Identifiable, Sendable {
    /// Unique identifier for this toast
    public let id: UUID
    /// The title text displayed prominently
    public let title: String
    /// Optional secondary message text
    public let message: String?
    /// The visual style (success, error, warning, info, custom)
    public let style: LuxeToastStyle
    /// Configuration controlling appearance and behavior
    public let configuration: LuxeToastConfiguration

    public init(
        id: UUID = UUID(),
        title: String,
        message: String? = nil,
        style: LuxeToastStyle = .info,
        configuration: LuxeToastConfiguration = .default
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.style = style
        self.configuration = configuration
    }
}

// MARK: - Toast Manager

/// A manager that queues and presents LuxeToast notifications.
///
/// `LuxeToastManager` holds a queue of toast items and handles their lifecycle
/// (display, auto-dismiss, swipe-dismiss). Inject it into the environment using
/// the `.luxeToast()` view modifier and access it via `@Environment(\.luxeToastManager)`.
///
/// ## Features
/// - **Queue System**: Multiple toasts stack gracefully
/// - **Auto-Dismiss**: Configurable timer per toast
/// - **Programmatic Dismiss**: Dismiss by ID or dismiss all
/// - **Thread-Safe**: Published on the main actor
///
/// ## Example
/// ```swift
/// @Environment(\.luxeToastManager) var toast
///
/// // Simple toast
/// toast.show("Saved successfully!", style: .success)
///
/// // Toast with message
/// toast.show("Network Error", message: "Please check your connection.", style: .error)
///
/// // Toast with custom configuration
/// toast.show("Uploading...", style: .info, configuration: .persistent)
///
/// // Dismiss all
/// toast.dismissAll()
/// ```
@MainActor
public final class LuxeToastManager: ObservableObject {
    /// The currently visible toast items
    @Published public private(set) var toasts: [LuxeToastItem] = []

    /// Maximum number of visible toasts at once. Default: 3
    public var maxVisibleToasts: Int = 3

    /// Active auto-dismiss timers keyed by toast ID
    private var timers: [UUID: Task<Void, Never>] = [:]

    public init() {}

    /// Show a new toast notification.
    ///
    /// - Parameters:
    ///   - title: The main text to display
    ///   - message: Optional secondary message
    ///   - style: Visual style (`.success`, `.error`, `.warning`, `.info`, `.custom(...)`)
    ///   - configuration: Appearance and behavior configuration
    public func show(
        _ title: String,
        message: String? = nil,
        style: LuxeToastStyle = .info,
        configuration: LuxeToastConfiguration = .default
    ) {
        let item = LuxeToastItem(
            title: title,
            message: message,
            style: style,
            configuration: configuration
        )

        // Trim oldest if over limit
        if toasts.count >= maxVisibleToasts {
            let removed = toasts.removeFirst()
            cancelTimer(for: removed.id)
        }

        toasts.append(item)

        // Haptics
        if configuration.enableHaptics {
            style.triggerHaptic()
        }

        // Auto-dismiss
        if let duration = configuration.autoDismissDuration {
            scheduleAutoDismiss(for: item.id, after: duration)
        }
    }

    /// Dismiss a specific toast by its ID.
    ///
    /// - Parameter id: The unique identifier of the toast to dismiss
    public func dismiss(_ id: UUID) {
        cancelTimer(for: id)
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            toasts.removeAll { $0.id == id }
        }
    }

    /// Dismiss all visible toasts.
    public func dismissAll() {
        for toast in toasts {
            cancelTimer(for: toast.id)
        }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            toasts.removeAll()
        }
    }

    // MARK: - Private Helpers

    private func scheduleAutoDismiss(for id: UUID, after duration: Double) {
        let task = Task { @MainActor [weak self] in
            try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            guard !Task.isCancelled else { return }
            self?.dismiss(id)
        }
        timers[id] = task
    }

    private func cancelTimer(for id: UUID) {
        timers[id]?.cancel()
        timers.removeValue(forKey: id)
    }
}

// MARK: - Environment Key

/// Environment key for the toast manager.
private struct LuxeToastManagerKey: EnvironmentKey {
    static let defaultValue: LuxeToastManager = LuxeToastManager()
}

public extension EnvironmentValues {
    /// The LuxeToast manager in the environment.
    ///
    /// Access this in any view to show toast notifications:
    /// ```swift
    /// @Environment(\.luxeToastManager) var toast
    /// toast.show("Hello!", style: .success)
    /// ```
    var luxeToastManager: LuxeToastManager {
        get { self[LuxeToastManagerKey.self] }
        set { self[LuxeToastManagerKey.self] = newValue }
    }
}

// MARK: - Toast View

/// The visual representation of a single toast notification.
///
/// `LuxeToastView` renders a glassmorphic card with an icon, title, optional message,
/// and a dismiss button. It supports swipe-to-dismiss gestures and glow effects.
///
/// You typically don't use this view directly. Instead, apply the `.luxeToast()` modifier
/// to your root view, which handles layout and presentation automatically.
struct LuxeToastView: View {
    let item: LuxeToastItem
    let onDismiss: () -> Void

    @Environment(\.luxeTheme) private var theme
    @State private var dragOffset: CGFloat = 0

    private var styleColor: Color { item.style.color(for: theme) }
    private var config: LuxeToastConfiguration { item.configuration }

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: item.style.iconName)
                .font(.system(size: config.iconSize, weight: .semibold))
                .foregroundColor(styleColor)
                .shadow(color: config.enableGlow ? styleColor.opacity(0.6) : .clear, radius: 4)

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.system(size: config.titleFontSize, weight: config.titleFontWeight))
                    .foregroundColor(theme.textColor)
                    .lineLimit(2)

                if let message = item.message {
                    Text(message)
                        .font(.system(size: config.messageFontSize))
                        .foregroundColor(theme.textSecondaryColor)
                        .lineLimit(2)
                }
            }

            Spacer(minLength: 4)

            // Dismiss button
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(theme.textSecondaryColor)
                    .padding(6)
                    .background(
                        Circle()
                            .fill(.white.opacity(0.1))
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, config.paddingHorizontal)
        .padding(.vertical, config.paddingVertical)
        .frame(maxWidth: config.maxWidth)
        .background(
            RoundedRectangle(cornerRadius: config.cornerRadius)
                .fill(.ultraThinMaterial)
                .background(
                    RoundedRectangle(cornerRadius: config.cornerRadius)
                        .fill(styleColor.opacity(config.backgroundOpacity))
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: config.cornerRadius)
                .stroke(
                    LinearGradient(
                        colors: [
                            styleColor.opacity(config.borderOpacity),
                            .white.opacity(config.borderOpacity * 0.4)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: config.borderWidth
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: config.cornerRadius))
        .shadow(
            color: config.enableGlow
                ? item.style.glowColor(for: theme).opacity(config.glowOpacity)
                : .black.opacity(0.2),
            radius: config.enableGlow ? config.glowRadius : config.shadowRadius,
            y: config.shadowY
        )
        .offset(y: dragOffset)
        .gesture(
            config.enableSwipeToDismiss
                ? DragGesture()
                    .onChanged { value in
                        let translation = config.position == .top
                            ? min(0, value.translation.height)
                            : max(0, value.translation.height)
                        dragOffset = translation
                    }
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        let shouldDismiss = config.position == .top
                            ? value.translation.height < -threshold
                            : value.translation.height > threshold
                        if shouldDismiss {
                            onDismiss()
                        } else {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                dragOffset = 0
                            }
                        }
                    }
                : nil
        )
    }
}

// MARK: - Toast Container

/// Internal container that overlays toast notifications on the view hierarchy.
///
/// This view is applied automatically by the `.luxeToast()` modifier.
/// It reads from `LuxeToastManager` and renders toasts with staggered transitions.
struct LuxeToastContainer: ViewModifier {
    @ObservedObject var manager: LuxeToastManager
    let defaultPosition: LuxeToastPosition

    func body(content: Content) -> some View {
        content
            .overlay(alignment: defaultPosition == .top ? .top : .bottom) {
                VStack(spacing: 8) {
                    ForEach(manager.toasts) { item in
                        LuxeToastView(item: item) {
                            manager.dismiss(item.id)
                        }
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: item.configuration.position == .top ? .top : .bottom)
                                    .combined(with: .opacity)
                                    .combined(with: .scale(scale: 0.9)),
                                removal: .move(edge: item.configuration.position == .top ? .top : .bottom)
                                    .combined(with: .opacity)
                            )
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(defaultPosition == .top ? .top : .bottom, 16)
                .animation(
                    .spring(response: 0.4, dampingFraction: 0.75),
                    value: manager.toasts.map(\.id)
                )
            }
    }
}

// MARK: - View Extension

public extension View {
    /// Attach the LuxeToast notification system to this view.
    ///
    /// Apply this modifier once at or near the root of your view hierarchy.
    /// It injects a `LuxeToastManager` into the environment that child views
    /// can use to present toast notifications.
    ///
    /// ## Example
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .luxeTheme(.midnight)
    ///                 .luxeToast()
    ///         }
    ///     }
    /// }
    ///
    /// struct ContentView: View {
    ///     @Environment(\.luxeToastManager) var toast
    ///
    ///     var body: some View {
    ///         Button("Show Toast") {
    ///             toast.show("Hello!", style: .success)
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - manager: Optional custom `LuxeToastManager`. A default is created if not provided.
    ///   - position: Default position for toasts (`.top` or `.bottom`). Individual toasts
    ///     can override this via their configuration.
    /// - Returns: A view with the toast overlay attached.
    func luxeToast(
        manager: LuxeToastManager? = nil,
        position: LuxeToastPosition = .top
    ) -> some View {
        let toastManager = manager ?? LuxeToastManager()
        return self
            .environmentObject(toastManager)
            .environment(\.luxeToastManager, toastManager)
            .modifier(LuxeToastContainer(manager: toastManager, defaultPosition: position))
    }
}
