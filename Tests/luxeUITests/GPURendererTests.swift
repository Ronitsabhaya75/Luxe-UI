import XCTest
import SwiftUI
@testable import LuxeUI

final class GPURendererTests: XCTestCase {
    
    // MARK: - Configuration Tests
    
    func testLiquidBlobConfigurationDefaults() {
        let config = LiquidBlobConfiguration.default
        XCTAssertTrue(config.enableGPU, "GPU should be enabled by default")
        
        let customConfig = LiquidBlobConfiguration(enableGPU: false)
        XCTAssertFalse(customConfig.enableGPU)
    }
    
    func testRefractiveGlassConfigurationDefaults() {
        let config = RefractiveGlassConfiguration.default
        XCTAssertTrue(config.enableGPU, "GPU should be enabled by default")
        
        let customConfig = RefractiveGlassConfiguration(enableGPU: false)
        XCTAssertFalse(customConfig.enableGPU)
    }
    
    func testLiquidProgressConfigurationDefaults() {
        let config = LiquidProgressConfiguration.default
        XCTAssertTrue(config.enableGPU, "GPU should be enabled by default")
        
        let customConfig = LiquidProgressConfiguration(enableGPU: false)
        XCTAssertFalse(customConfig.enableGPU)
    }
    
    func testLiquidLoaderConfigurationDefaults() {
        let config = LiquidLoaderConfiguration.default
        XCTAssertTrue(config.enableGPU, "GPU should be enabled by default")
        
        let customConfig = LiquidLoaderConfiguration(enableGPU: false)
        XCTAssertFalse(customConfig.enableGPU)
    }
    
    // MARK: - View Instantiation Smoke Tests
    
    func testLiquidBlobInstantiation() {
        let view = LiquidBlob(colors: [.red, .blue])
        XCTAssertNotNil(view, "Should instantiate with default config")
        
        let cpuView = LiquidBlob(colors: [.red, .blue], configuration: LiquidBlobConfiguration(enableGPU: false))
        XCTAssertNotNil(cpuView, "Should instantiate with CPU only")
    }
    
    func testLiquidLoaderInstantiation() {
        let view = LiquidLoader()
        XCTAssertNotNil(view)
        
        let cpuView = LiquidLoader(configuration: LiquidLoaderConfiguration(enableGPU: false))
        XCTAssertNotNil(cpuView)
    }
    
    func testLiquidProgressInstantiation() {
        let view = LiquidProgress(progress: 0.5)
        XCTAssertNotNil(view)
        
        let cpuView = LiquidProgress(progress: 0.5, configuration: LiquidProgressConfiguration(enableGPU: false))
        XCTAssertNotNil(cpuView)
    }
    
    func testRefractiveGlassInstantiation() {
        let view = Text("Test").refractiveGlass()
        XCTAssertNotNil(view)
        
        let defaultView = Text("Test").modifier(RefractiveGlassModifier(configuration: RefractiveGlassConfiguration(enableGPU: true)))
        XCTAssertNotNil(defaultView)
        
        let cpuView = Text("Test").modifier(RefractiveGlassModifier(configuration: RefractiveGlassConfiguration(enableGPU: false)))
        XCTAssertNotNil(cpuView)
    }
    
    func testAdvancedGlassCardInstantiation() {
        let view = RefractiveGlassCard {
            Text("Content")
        }
        XCTAssertNotNil(view)
        
        let advanced = AdvancedRefractiveGlass {
            Text("Advanced")
        }
        XCTAssertNotNil(advanced)
    }
    
    // MARK: - Availability Base Tests
    
    func testAvailabilityConstructs() {
        if #available(iOS 17.0, macOS 14.0, *) {
            let rect = Rectangle()
            let modified = rect.gpuLiquidBlob(size: CGSize(width: 100, height: 100), phase: 0, morphIntensity: 0.5)
            XCTAssertNotNil(modified)
        }
    }
}
