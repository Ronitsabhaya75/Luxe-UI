import XCTest
import SwiftUI
@testable import LuxeUI

final class GPURendererTests: XCTestCase {
    
    // MARK: - Configuration Tests
    
    func testLiquidBlobConfigurationDefaults() {
        let config = LiquidBlobConfiguration.default
        XCTAssertTrue(config.enableGPU, "GPU should be enabled by default")
        XCTAssertEqual(config.animationDuration, 8.0)
        XCTAssertEqual(config.morphIntensity, 0.3)
        XCTAssertEqual(config.pulseScale, 1.1)
        
        let customConfig = LiquidBlobConfiguration(morphIntensity: 0.8, enableGPU: false)
        XCTAssertFalse(customConfig.enableGPU)
        XCTAssertEqual(customConfig.morphIntensity, 0.8)
    }
    
    func testRefractiveGlassConfigurationDefaults() {
        let config = RefractiveGlassConfiguration.default
        XCTAssertTrue(config.enableGPU, "GPU should be enabled by default")
        XCTAssertEqual(config.causticSpeed, 0.5)
        
        let customConfig = RefractiveGlassConfiguration(aberrationStrength: 0.8, enableGPU: false)
        XCTAssertFalse(customConfig.enableGPU)
        XCTAssertEqual(customConfig.aberrationStrength, 0.8)
    }
    
    func testLiquidProgressConfigurationDefaults() {
        let config = LiquidProgressConfiguration.default
        XCTAssertTrue(config.enableGPU, "GPU should be enabled by default")
        XCTAssertEqual(config.speed, 3.0)
        XCTAssertEqual(config.amplitude, 4.0)
        
        let customConfig = LiquidProgressConfiguration(amplitude: 10.0, enableGPU: false)
        XCTAssertFalse(customConfig.enableGPU)
        XCTAssertEqual(customConfig.amplitude, 10.0)
    }
    
    func testLiquidLoaderConfigurationDefaults() {
        let config = LiquidLoaderConfiguration.default
        XCTAssertTrue(config.enableGPU, "GPU should be enabled by default")
        XCTAssertEqual(config.circleCount, 5)
        
        let customConfig = LiquidLoaderConfiguration(circleCount: 8, enableGPU: false)
        XCTAssertFalse(customConfig.enableGPU)
        XCTAssertEqual(customConfig.circleCount, 8)
    }
    
    // MARK: - View Instantiation and Property Binding Tests
    // SwiftUI encapsulates view struct variables dynamically. We use Mirror to test these private assignments.
    
    func testLiquidBlobBindings() {
        let colors: [Color] = [.red, .blue]
        let view = LiquidBlob(colors: colors, size: 250, configuration: LiquidBlobConfiguration(morphIntensity: 0.7, enableGPU: false))
        
        let mirror = Mirror(reflecting: view)
        
        let mirroredColors = mirror.descendant("colors") as? [Color]
        XCTAssertEqual(mirroredColors, colors, "LiquidBlob should correctly bind colors")
        
        let mirroredSize = mirror.descendant("size") as? CGFloat
        XCTAssertEqual(mirroredSize, 250, "LiquidBlob should correctly bind size")
        
        let mirroredConfig = mirror.descendant("configuration") as? LiquidBlobConfiguration
        XCTAssertNotNil(mirroredConfig, "Configuration should be bound")
        XCTAssertFalse(mirroredConfig!.enableGPU, "LiquidBlob should correctly bind the GPU configuration override")
        XCTAssertEqual(mirroredConfig!.morphIntensity, 0.7)
    }
    
    func testLiquidLoaderBindings() {
        let view = LiquidLoader(configuration: LiquidLoaderConfiguration(speed: 2.5, enableGPU: false))
        
        let mirror = Mirror(reflecting: view)
        let mirroredConfig = mirror.descendant("configuration") as? LiquidLoaderConfiguration
        
        XCTAssertNotNil(mirroredConfig)
        XCTAssertFalse(mirroredConfig!.enableGPU)
        XCTAssertEqual(mirroredConfig!.speed, 2.5)
    }
    
    func testLiquidProgressBindings() {
        let view = LiquidProgress(progress: 0.65, configuration: LiquidProgressConfiguration(height: 45, enableGPU: false))
        
        let mirror = Mirror(reflecting: view)
        
        let mirroredProgress = mirror.descendant("progress") as? CGFloat
        XCTAssertEqual(mirroredProgress, 0.65)
        
        let mirroredConfig = mirror.descendant("configuration") as? LiquidProgressConfiguration
        XCTAssertNotNil(mirroredConfig)
        XCTAssertFalse(mirroredConfig!.enableGPU)
        XCTAssertEqual(mirroredConfig!.height, 45)
    }
    
    func testRefractiveGlassWrapperBindings() {
        let config = RefractiveGlassConfiguration(causticSpeed: 0.9, enableGPU: true)
        let modifier = RefractiveGlassModifier(configuration: config)
        
        let mirror = Mirror(reflecting: modifier)
        let mirroredConfig = mirror.descendant("configuration") as? RefractiveGlassConfiguration
        
        XCTAssertNotNil(mirroredConfig)
        XCTAssertTrue(mirroredConfig!.enableGPU)
        XCTAssertEqual(mirroredConfig!.causticSpeed, 0.9)
    }
    
    // MARK: - Availability Base Tests
    
    func testGPUModifierAvailabilitySyntax() {
        // Assert that the compiler permits these native view modifiers to construct without throwing context errors.
        if #available(iOS 17.0, macOS 14.0, *) {
            let rect = Rectangle()
            let blobModified = rect.gpuLiquidBlob(size: CGSize(width: 100, height: 100), phase: 0, morphIntensity: 0.5)
            let loaderModified = rect.gpuMetaballLoader(size: CGSize(width: 50, height: 50), timeOffset: 1, circleCount: 3, scaleEffect: 1)
            let waveModified = rect.gpuLiquidWave(size: CGSize(width: 100, height: 10), progress: 0.5, amplitude: 2, frequency: 1, phase: 0)
            
            XCTAssertNotNil(blobModified)
            XCTAssertNotNil(loaderModified)
            XCTAssertNotNil(waveModified)
        }
    }
}
