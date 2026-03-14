# iOS GPU Demo App

This is an interactive demo app showcasing LuxeUI's GPU-accelerated rendering on iOS.

## Features

- **Tab 1: Liquid Blob Effects** - Animated blob shapes with Metal shader rendering
- **Tab 2: Refractive Glass** - Glassmorphism cards with GPU distortion effects
- **Tab 3: Progress & Loading** - Animated progress bars and liquid loaders
- **Tab 4: Buttons & Interactions** - GPU-accelerated button components

## Running the Demo

### From Xcode
1. Open this project in Xcode
2. Select "iOSGPUDemo" as the active scheme
3. Choose an iPhone simulator (iPhone 16, iPhone 15, etc.)
4. Press ⌘R to run

### From Command Line
```bash
cd Examples/iOSGPUDemo
swift run -c debug
```

### Viewing on Simulator
- Swipe between tabs to explore different GPU rendering effects
- The app demonstrates real-time Metal shader processing
- Watch the animations to see the GPU acceleration in action
- Try the interactive controls (tap buttons, adjust progress)

## Requirements

- iOS 14.0+
- iPhone or iPad simulator
- Xcode 15.0+
- LuxeUI (automatically available via package dependency)

## GPU Rendering Features Demonstrated

1. **Metal Shaders** - Direct GPU computation for:
   - Liquid blob morphing
   - Lens distortion
   - Chromatic aberration
   - Caustic light effects

2. **SwiftUI Integration** - Seamless GPU effects in declarative UI

3. **Real-time Performance** - Smooth 60+ FPS animations

## Troubleshooting

If the app crashes:
- Ensure your iOS simulator is up to date
- Rebuild the LuxeUI package
- Check the build logs for Metal shader compilation errors

For GPU rendering issues:
- Xcode > Window > Devices and Simulators > Reset Contents and Settings
- Try a different simulator device
- Check that Metal is properly supported on your Mac
