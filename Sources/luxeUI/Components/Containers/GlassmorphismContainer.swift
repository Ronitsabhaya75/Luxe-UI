import SwiftUI

// MARK: - Glassmorphism Configuration

/// Configuration options for GlassmorphismContainer appearance.
///
/// `GlassmorphismConfiguration` provides control over the glassmorphic effect including
/// blur, opacity, borders, and shadows. Use presets for quick styling or customize
/// individual properties for precise control.
///
/// ## Overview
/// Glassmorphism is a modern design trend featuring frosted glass-like elements with:
/// - Background blur that shows content behind
/// - Subtle gradients and borders
/// - Layered depth with shadows
///
/// ## Presets
/// - `default`: Balanced glass effect
/// - `frosted`: Heavy blur, more opaque
/// - `clear`: Lighter, more transparent
/// - `dark`: Dark-tinted glass
/// - `vibrant`: Higher contrast borders
/// - `minimal`: No borders or inner shadows
///
/// ## Example
/// ```swift
/// GlassmorphismContainer(configuration: .frosted) {
///     Text("Frosted Glass")
/// }
/// ```
public struct GlassmorphismConfiguration: Sendable {
    /// The blur radius for the glass effect. Default: 20
    public var blurRadius: CGFloat
    /// The opacity of the background fill. Default: 0.3
    public var backgroundOpacity: Double
    /// The corner radius of the container. Default: 20
    public var cornerRadius: CGFloat
    /// The width of the border stroke. Default: 1
    public var borderWidth: CGFloat
    /// The opacity of the border. Default: 0.2
    public var borderOpacity: Double
    /// The gradient colors for the background overlay
    public var gradientColors: [Color]
    /// The color of the drop shadow. Default: .black
    public var shadowColor: Color
    /// The blur radius of the shadow. Default: 20
    public var shadowRadius: CGFloat
    /// The horizontal offset of the shadow. Default: 0
    public var shadowX: CGFloat
    /// The vertical offset of the shadow. Default: 10
    public var shadowY: CGFloat
    /// The opacity of the inner shadow. Default: 0.1
    public var innerShadowOpacity: Double
    /// Whether to show the inner shadow. Default: true
    public var enableInnerShadow: Bool
    /// Whether to show the border. Default: true
    public var enableBorder: Bool
    
    public init(
        blurRadius: CGFloat = 20,
        backgroundOpacity: Double = 0.3,
        cornerRadius: CGFloat = 20,
        borderWidth: CGFloat = 1,
        borderOpacity: Double = 0.2,
        gradientColors: [Color] = [.white.opacity(0.3), .white.opacity(0.1)],
        shadowColor: Color = .black,
        shadowRadius: CGFloat = 20,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 10,
        innerShadowOpacity: Double = 0.1,
        enableInnerShadow: Bool = true,
        enableBorder: Bool = true
    ) {
        self.blurRadius = blurRadius
        self.backgroundOpacity = backgroundOpacity
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderOpacity = borderOpacity
        self.gradientColors = gradientColors
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowX = shadowX
        self.shadowY = shadowY
        self.innerShadowOpacity = innerShadowOpacity
        self.enableInnerShadow = enableInnerShadow
        self.enableBorder = enableBorder
    }
    
    // Presets
    public static let `default` = GlassmorphismConfiguration()
    
    public static let frosted = GlassmorphismConfiguration(
        blurRadius: 30,
        backgroundOpacity: 0.4,
        borderOpacity: 0.3
    )
    
    public static let clear = GlassmorphismConfiguration(
        blurRadius: 10,
        backgroundOpacity: 0.15,
        borderOpacity: 0.15
    )
    
    public static let dark = GlassmorphismConfiguration(
        blurRadius: 25,
        backgroundOpacity: 0.5,
        gradientColors: [.black.opacity(0.3), .black.opacity(0.1)],
        shadowRadius: 30
    )
    
    public static let vibrant = GlassmorphismConfiguration(
        blurRadius: 15,
        backgroundOpacity: 0.25,
        borderOpacity: 0.4,
        gradientColors: [.white.opacity(0.4), .white.opacity(0.2)]
    )
    
    public static let minimal = GlassmorphismConfiguration(
        blurRadius: 8,
        backgroundOpacity: 0.1,
        enableInnerShadow: false,
        enableBorder: false
    )
}

// MARK: - Glassmorphism Container

/// A container view with a frosted glass effect background.
///
/// `GlassmorphismContainer` wraps content in a modern glassmorphic container with
/// blur effects, gradient overlays, and subtle borders. The effect shows content
/// behind the container while adding visual depth.
///
/// ## Features
/// - **Blur Effect**: Uses SwiftUI's `.ultraThinMaterial` with additional blur
/// - **Gradient Overlay**: Subtle gradient for depth and light simulation
/// - **Border**: Gradient stroke for edge definition
/// - **Inner Shadow**: Optional depth effect
/// - **Drop Shadow**: Floating appearance with configurable shadow
/// - **Hover Effect**: Slight scale animation on hover
///
/// ## Example
/// ```swift
/// GlassmorphismContainer {
///     VStack {
///         Text("Glass Card")
///             .font(.headline)
///         Text("With frosted effect")
///             .font(.caption)
///     }
///     .padding()
/// }
/// .frame(width: 200, height: 150)
/// ```
///
/// ## Presets
/// Use configuration presets for quick styling:
/// ```swift
/// GlassmorphismContainer(configuration: .frosted) {
///     // Content
/// }
/// ```
public struct GlassmorphismContainer<Content: View>: View {
    private let content: Content
    private var configuration: GlassmorphismConfiguration
    
    // Callbacks
    private var onHoverStart: (() -> Void)?
    private var onHoverEnd: (() -> Void)?
    private var onTapAction: (() -> Void)?
    
    @State private var isHovered = false
    
    public init(
        configuration: GlassmorphismConfiguration = .default,
        @ViewBuilder content: () -> Content
    ) {
        self.configuration = configuration
        self.content = content()
    }
    
    /// Convenience initializer with common parameters
    public init(
        blurRadius: CGFloat = 20,
        opacity: Double = 0.3,
        cornerRadius: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.configuration = GlassmorphismConfiguration(
            blurRadius: blurRadius,
            backgroundOpacity: opacity,
            cornerRadius: cornerRadius
        )
        self.content = content()
    }
    
    public var body: some View {
        content
            .background(
                ZStack {
                    // Blur background
                    RoundedRectangle(cornerRadius: configuration.cornerRadius)
                        .fill(.ultraThinMaterial)
                    
                    // Gradient overlay
                    RoundedRectangle(cornerRadius: configuration.cornerRadius)
                        .fill(
                            LinearGradient(
                                colors: configuration.gradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .opacity(configuration.backgroundOpacity)
                    
                    // Inner shadow for depth
                    if configuration.enableInnerShadow {
                        RoundedRectangle(cornerRadius: configuration.cornerRadius)
                            .stroke(.black.opacity(configuration.innerShadowOpacity), lineWidth: 2)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(
                                RoundedRectangle(cornerRadius: configuration.cornerRadius)
                                    .fill(
                                        LinearGradient(
                                            colors: [.black, .clear],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                    }
                }
            )
            .overlay(
                Group {
                    if configuration.enableBorder {
                        RoundedRectangle(cornerRadius: configuration.cornerRadius)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        .white.opacity(configuration.borderOpacity),
                                        .white.opacity(configuration.borderOpacity * 0.5)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: configuration.borderWidth
                            )
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: configuration.cornerRadius))
            .shadow(
                color: configuration.shadowColor.opacity(0.3),
                radius: configuration.shadowRadius,
                x: configuration.shadowX,
                y: configuration.shadowY
            )
            .scaleEffect(isHovered ? 1.01 : 1.0)
            .animation(.spring(response: 0.3), value: isHovered)
            .onHover { hovering in
                isHovered = hovering
                if hovering {
                    onHoverStart?()
                } else {
                    onHoverEnd?()
                }
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        onTapAction?()
                    }
            )
    }
    
    // Modifier methods
    public func onHoverStart(_ action: @escaping () -> Void) -> GlassmorphismContainer {
        var copy = self
        copy.onHoverStart = action
        return copy
    }
    
    public func onHoverEnd(_ action: @escaping () -> Void) -> GlassmorphismContainer {
        var copy = self
        copy.onHoverEnd = action
        return copy
    }
    
    public func onTap(_ action: @escaping () -> Void) -> GlassmorphismContainer {
        var copy = self
        copy.onTapAction = action
        return copy
    }
    
    public func blur(_ radius: CGFloat) -> GlassmorphismContainer {
        var copy = self
        copy.configuration.blurRadius = radius
        return copy
    }
    
    public func opacity(_ value: Double) -> GlassmorphismContainer {
        var copy = self
        copy.configuration.backgroundOpacity = value
        return copy
    }
    
    public func cornerRadius(_ radius: CGFloat) -> GlassmorphismContainer {
        var copy = self
        copy.configuration.cornerRadius = radius
        return copy
    }
    
    public func border(_ enabled: Bool, width: CGFloat = 1, opacity: Double = 0.2) -> GlassmorphismContainer {
        var copy = self
        copy.configuration.enableBorder = enabled
        copy.configuration.borderWidth = width
        copy.configuration.borderOpacity = opacity
        return copy
    }
    
    public func shadow(color: Color = .black, radius: CGFloat = 20, x: CGFloat = 0, y: CGFloat = 10) -> GlassmorphismContainer {
        var copy = self
        copy.configuration.shadowColor = color
        copy.configuration.shadowRadius = radius
        copy.configuration.shadowX = x
        copy.configuration.shadowY = y
        return copy
    }
}

// MARK: - Glassmorphism Modifier

public struct GlassmorphismModifier: ViewModifier {
    private let configuration: GlassmorphismConfiguration
    
    public init(configuration: GlassmorphismConfiguration = .default) {
        self.configuration = configuration
    }

    
    
    public func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: configuration.cornerRadius)
                        .fill(.ultraThinMaterial)
                    
                    RoundedRectangle(cornerRadius: configuration.cornerRadius)
                        .fill(
                            LinearGradient(
                                colors: configuration.gradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .opacity(configuration.backgroundOpacity)
                }
            )
            .overlay(
                Group {
                    if configuration.enableBorder {
                        RoundedRectangle(cornerRadius: configuration.cornerRadius)
                            .stroke(
                                .white.opacity(configuration.borderOpacity),
                                lineWidth: configuration.borderWidth
                            )
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: configuration.cornerRadius))
            .shadow(
                color: configuration.shadowColor.opacity(0.3),
                radius: configuration.shadowRadius,
                x: configuration.shadowX,
                y: configuration.shadowY
            )
    }
}

// MARK: - View Extension

public extension View {
    func glassmorphism(configuration: GlassmorphismConfiguration = .default) -> some View {
        self.modifier(GlassmorphismModifier(configuration: configuration))
    }
    
    func glassmorphism(
        blur: CGFloat = 20,
        opacity: Double = 0.3,
        cornerRadius: CGFloat = 20,
        borderWidth: CGFloat = 1,
        borderOpacity: Double = 0.2
    ) -> some View {
        let config = GlassmorphismConfiguration(
            blurRadius: blur,
            backgroundOpacity: opacity,
            cornerRadius: cornerRadius,
            borderWidth: borderWidth,
            borderOpacity: borderOpacity
        )
        return self.modifier(GlassmorphismModifier(configuration: config))
    }
}
