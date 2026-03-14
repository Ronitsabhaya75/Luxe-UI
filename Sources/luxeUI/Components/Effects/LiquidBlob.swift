import SwiftUI

/// An animated blob shape with liquid morphing effects.
///
/// `LiquidBlob` creates organic, morphing shapes that pulse and animate smoothly.
/// Perfect for backgrounds, decorative elements, and interactive effects.
///
/// ## Example
/// ```swift
/// LiquidBlob(
///     colors: [.blue, .purple],
///     size: 200,
///     configuration: .pulsing
/// )
/// ```

// MARK: - Configuration

public struct LiquidBlobConfiguration: Sendable {
    public var animationDuration: Double
    public var morphIntensity: CGFloat
    public var pulseScale: CGFloat
    public var rotationEnabled: Bool
    public var blurRadius: CGFloat
    public var enableGPU: Bool
    
    public init(
        animationDuration: Double = 8.0,
        morphIntensity: CGFloat = 0.3,
        pulseScale: CGFloat = 1.1,
        rotationEnabled: Bool = true,
        blurRadius: CGFloat = 20,
        enableGPU: Bool = true
    ) {
        self.animationDuration = animationDuration
        self.morphIntensity = morphIntensity
        self.pulseScale = pulseScale
        self.rotationEnabled = rotationEnabled
        self.blurRadius = blurRadius
        self.enableGPU = enableGPU
    }
    
    public static let `default` = LiquidBlobConfiguration()
    public static let pulsing = LiquidBlobConfiguration(pulseScale: 1.2)
    public static let subtle = LiquidBlobConfiguration(morphIntensity: 0.15, pulseScale: 1.05)
    public static let intense = LiquidBlobConfiguration(morphIntensity: 0.5, pulseScale: 1.3)
}

// MARK: - Liquid Blob Component

public struct LiquidBlob: View {
    private let colors: [Color]
    private let size: CGFloat
    private let configuration: LiquidBlobConfiguration
    
    @State private var phase: CGFloat = 0
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    
    public init(
        colors: [Color],
        size: CGFloat = 200,
        configuration: LiquidBlobConfiguration = .default
    ) {
        self.colors = colors
        self.size = size
        self.configuration = configuration
    }
    
    public var body: some View {
        Group {
            if configuration.enableGPU {
                if #available(iOS 17.0, macOS 14.0, *) {
                    gpuBody
                } else {
                    cpuBody
                }
            } else {
                cpuBody
            }
        }
        .scaleEffect(scale)
        .rotationEffect(.degrees(rotation))
        .onAppear {
            startAnimations()
        }
    }
    
    @available(iOS 17.0, macOS 14.0, *)
    private var gpuBody: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { index in
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: colors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                    .gpuLiquidBlob(
                        size: CGSize(width: size, height: size),
                        phase: phase + Double(index) * 0.33,
                        morphIntensity: configuration.morphIntensity
                    )
                    .blur(radius: configuration.blurRadius)
                    .opacity(0.7 - Double(index) * 0.2)
                    .scaleEffect(1.0 + CGFloat(index) * 0.1)
            }
        }
    }
    
    private var cpuBody: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { index in
                BlobShape(
                    phase: phase + CGFloat(index) * 0.33,
                    morphIntensity: configuration.morphIntensity
                )
                .fill(
                    LinearGradient(
                        colors: colors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)
                .blur(radius: configuration.blurRadius)
                .opacity(0.7 - Double(index) * 0.2)
                .scaleEffect(1.0 + CGFloat(index) * 0.1)
            }
        }
    }
    
    private func startAnimations() {
        // Morphing animation
        withAnimation(
            .linear(duration: configuration.animationDuration)
            .repeatForever(autoreverses: false)
        ) {
            phase = 1.0
        }
        
        // Pulsing animation
        withAnimation(
            .easeInOut(duration: configuration.animationDuration / 2)
            .repeatForever(autoreverses: true)
        ) {
            scale = configuration.pulseScale
        }
        
        // Rotation animation
        if configuration.rotationEnabled {
            withAnimation(
                .linear(duration: configuration.animationDuration * 2)
                .repeatForever(autoreverses: false)
            ) {
                rotation = 360
            }
        }
    }
}

// MARK: - Blob Shape

struct BlobShape: Shape {
    var phase: CGFloat
    var morphIntensity: CGFloat
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let centerX = width / 2
        let centerY = height / 2
        
        var path = Path()
        
        let points = 8
        let angleStep = (2 * .pi) / CGFloat(points)
        
        // Create organic blob shape
        for i in 0..<points {
            let angle = angleStep * CGFloat(i) + phase * 2 * .pi
            
            // Vary radius with sine waves for organic morphing
            let radiusVariation = sin(angle * 3 + phase * 4 * .pi) * morphIntensity
            let radius = min(width, height) / 2 * (1.0 + radiusVariation)
            
            let x = centerX + cos(angle) * radius
            let y = centerY + sin(angle) * radius
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                // Use quadratic curves for smooth, liquid edges
                let prevAngle = angleStep * CGFloat(i - 1) + phase * 2 * .pi
                let prevRadiusVar = sin(prevAngle * 3 + phase * 4 * .pi) * morphIntensity
                let prevRadius = min(width, height) / 2 * (1.0 + prevRadiusVar)
                let prevX = centerX + cos(prevAngle) * prevRadius
                let prevY = centerY + sin(prevAngle) * prevRadius
                
                let controlX = (prevX + x) / 2
                let controlY = (prevY + y) / 2
                
                path.addQuadCurve(
                    to: CGPoint(x: x, y: y),
                    control: CGPoint(x: controlX, y: controlY)
                )
            }
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Convenience Modifiers

public extension View {
    /// Adds a liquid blob background to the view
    func liquidBlobBackground(
        colors: [Color],
        size: CGFloat = 300,
        configuration: LiquidBlobConfiguration = .default
    ) -> some View {
        self.background(
            LiquidBlob(colors: colors, size: size, configuration: configuration)
        )
    }
}

// MARK: - Preview

#if DEBUG
struct LiquidBlob_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 60) {
                LiquidBlob(
                    colors: [.blue, .purple],
                    size: 200,
                    configuration: .default
                )
                
                LiquidBlob(
                    colors: [.pink, .orange],
                    size: 150,
                    configuration: .pulsing
                )
                
                LiquidBlob(
                    colors: [.green, .cyan],
                    size: 180,
                    configuration: .intense
                )
            }
        }
    }
}
#endif
