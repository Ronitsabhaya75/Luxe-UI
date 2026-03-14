# iOS GPU Demo App

GPU-accelerated rendering demo showcasing LuxeUI effects on iOS/iPhone simulator.

## Running the Demo

### Prerequisites
- macOS with Xcode installed
- iPhone simulator (any iOS 16+ device)

### Quick Start

**Open in Xcode:**
```bash
cd Examples/iOSGPUDemo
open .  # Opens in Xcode
```

**Or run from command line:**
```bash
cd Examples/iOSGPUDemo
swift build
# Then select the scheme in Xcode and run on simulator
```

## Features Demonstrated

1. **Refractive Glass** - Lens distortion + chromatic aberration + caustic light effects
2. **Liquid Blob** - Smooth morphing liquid animation using Metal shaders
3. **Liquid Loader** - Metaball-based loading indicator
4. **Circular Progress** - Gradient progress bar with GPU acceleration

## GPU Effects in Action

- Metal shader compilation and execution
- Real-time distortion effects
- Caustic light simulation
- Liquid/metaball animations
- Progress visualization

## Troubleshooting

If the simulator doesn't launch:
1. Make sure you have an iOS 16+ simulator installed
2. Check that LuxeUI package is properly linked
3. Run `swift build` first to ensure compilation

## Performance Notes

GPU rendering provides smooth 60+ FPS animations on:
- iPhone Pro models
- iPad Pro devices
- iPad Air 5+

Older simulators may show reduced performance due to Metal shader limitations.
