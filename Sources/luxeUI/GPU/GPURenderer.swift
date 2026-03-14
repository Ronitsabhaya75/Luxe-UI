import SwiftUI

// MARK: - GPURenderer Modifiers

@available(iOS 17.0, macOS 14.0, *)
public extension View {
    
    /// Applies the GPU liquid blob metal shader.
    func gpuLiquidBlob(size: CGSize, phase: Double, morphIntensity: CGFloat) -> some View {
        self.colorEffect(
            ShaderLibrary.liquidBlob(
                .float2(size),
                .float(phase),
                .float(morphIntensity)
            )
        )
    }
    
    /// Applies the caustic light overlay metal shader.
    func gpuCaustics(size: CGSize, phase: Double, causticCount: Int) -> some View {
        self.colorEffect(
            ShaderLibrary.causticLight(
                .float2(size),
                .float(phase),
                .float(Float(causticCount))
            )
        )
    }
    
    /// Applies RGB split chromatic aberration via metal layer shader.
    func gpuChromaticAberration(strength: CGFloat) -> some View {
        self.layerEffect(
            ShaderLibrary.chromaticAberration(
                .float(strength)
            ),
            maxSampleOffset: CGSize(width: strength, height: strength)
        )
    }
    
    /// Applies the liquid wave sine function via metal shader.
    func gpuLiquidWave(size: CGSize, progress: Double, amplitude: CGFloat, frequency: CGFloat, phase: Double) -> some View {
        self.colorEffect(
            ShaderLibrary.liquidWave(
                .float2(size),
                .float(progress),
                .float(amplitude),
                .float(frequency),
                .float(phase)
            )
        )
    }
    
    /// Computes orbiting SDF metaballs via metal shader.
    func gpuMetaballLoader(size: CGSize, timeOffset: Double, circleCount: Int, scaleEffect: CGFloat) -> some View {
        self.colorEffect(
            ShaderLibrary.metaballLoader(
                .float2(size),
                .float(timeOffset),
                .float(Float(circleCount)),
                .float(scaleEffect)
            )
        )
    }
    
    /// Applies lens distortion (pincushion/barrel) via metal distortion shader.
    func gpuLensDistortion(size: CGSize, intensity: Double, radius: CGFloat) -> some View {
        let maxOffset = max(1.0, CGFloat(intensity) * radius * 0.1)
        return self.distortionEffect(
            ShaderLibrary.lensDistortion(
                .float2(size),
                .float(intensity),
                .float(radius)
            ),
            maxSampleOffset: CGSize(width: maxOffset, height: maxOffset)
        )
    }
}
