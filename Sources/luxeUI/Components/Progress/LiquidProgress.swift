import SwiftUI

// MARK: - Liquid Progress Configuration

/// Configuration options for the LiquidProgress component.
public struct LiquidProgressConfiguration: Sendable {
    public var height: CGFloat
    public var colors: [Color]
    public var amplitude: CGFloat
    public var frequency: CGFloat
    public var speed: Double
    public var cornerRadius: CGFloat
    public var backgroundColor: Color
    public var backgroundOpacity: Double
    public var enableGPU: Bool
    
    public init(
        height: CGFloat = 20,
        colors: [Color] = [.blue, .cyan],
        amplitude: CGFloat = 4,
        frequency: CGFloat = 1.5,
        speed: Double = 3.0,
        cornerRadius: CGFloat = 10,
        backgroundColor: Color = .gray,
        backgroundOpacity: Double = 0.2,
        enableGPU: Bool = true
    ) {
        self.height = height
        self.colors = colors
        self.amplitude = amplitude
        self.frequency = frequency
        self.speed = speed
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.backgroundOpacity = backgroundOpacity
        self.enableGPU = enableGPU
    }
    
    public static let `default` = LiquidProgressConfiguration()
    public static let large = LiquidProgressConfiguration(height: 40, amplitude: 8, cornerRadius: 20)
    public static let subtle = LiquidProgressConfiguration(height: 10, amplitude: 2, speed: 2.0)
    public static let ocean = LiquidProgressConfiguration(colors: [.blue, .teal], amplitude: 5, speed: 4.0)
}

// MARK: - Liquid Progress Component

/// A progress bar with a liquid wave animation.
///
/// `LiquidProgress` visualizes progress as a rising liquid level with an animated
/// wave surface.
///
/// ## Example
/// ```swift
/// LiquidProgress(progress: 0.6, configuration: .large)
/// ```
public struct LiquidProgress: View {
    private let progress: Double
    private let configuration: LiquidProgressConfiguration
    
    @State private var phase: Double = 0
    
    public init(
        progress: Double,
        configuration: LiquidProgressConfiguration = .default
    ) {
        self.progress = max(0, min(1, progress))
        self.configuration = configuration
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: configuration.cornerRadius)
                    .fill(configuration.backgroundColor.opacity(configuration.backgroundOpacity))
                
                // Liquid Wave Fill
                if configuration.enableGPU {
                    if #available(iOS 17.0, macOS 14.0, *) {
                        Rectangle()
                            .fill(LinearGradient(colors: configuration.colors, startPoint: .leading, endPoint: .trailing))
                            .gpuLiquidWave(
                                size: geometry.size,
                                progress: progress,
                                amplitude: configuration.amplitude,
                                frequency: configuration.frequency,
                                phase: phase
                            )
                            .mask(RoundedRectangle(cornerRadius: configuration.cornerRadius))
                    } else {
                        cpuWaveFill
                    }
                } else {
                    cpuWaveFill
                }
            }
        }
        .frame(height: configuration.height)
        .onAppear {
            withAnimation(.linear(duration: configuration.speed).repeatForever(autoreverses: false)) {
                phase = .pi * 2
            }
        }
    }
    
    private var cpuWaveFill: some View {
        WaveShape(
            progress: progress,
            amplitude: configuration.amplitude,
            frequency: configuration.frequency,
            phase: phase
        )
        .fill(
            LinearGradient(
                colors: configuration.colors,
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .mask(
            RoundedRectangle(cornerRadius: configuration.cornerRadius)
        )
    }
}

// MARK: - Wave Shape

struct WaveShape: Shape {
    var progress: Double
    var amplitude: CGFloat
    var frequency: CGFloat
    var phase: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(progress, phase) }
        set {
            progress = newValue.first
            phase = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        // Calculate the base Y position based on progress (inverted because Y grows downwards)
        // 0% -> height, 100% -> 0
        let baseHeight = height * (1 - CGFloat(progress))
        
        // Move to start point
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: baseHeight))
        
        // Draw sine wave
        for x in stride(from: 0, to: width, by: 2) {
            let relativeX = x / width
            let sine = sin(relativeX * frequency * .pi * 2 + phase)
            let y = baseHeight + CGFloat(sine) * amplitude
            
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // Close path
        path.addLine(to: CGPoint(x: width, y: baseHeight)) // Ensure we reach the end
        path.addLine(to: CGPoint(x: width, y: height))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Preview

#if DEBUG
struct LiquidProgress_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 40) {
                LiquidProgress(progress: 0.5)
                    .padding()
                
                LiquidProgress(progress: 0.75, configuration: .large)
                    .padding()
                
                LiquidProgress(progress: 0.3, configuration: .ocean)
                    .padding()
            }
        }
    }
}
#endif
