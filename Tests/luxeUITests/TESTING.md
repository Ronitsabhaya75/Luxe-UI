# Testing Guide

LuxeUI uses the Swift Testing framework for comprehensive test coverage. This guide covers how to run tests, understand the test structure, and contribute new tests.

## Quick Start

```bash
# Run all tests
swift test

# Run tests with verbose output
swift test --verbose

# Run specific test suite
swift test --filter "ThemeTests"

# Run smoke tests only
swift test --filter "SmokeTests"

# Run UI tests only
swift test --filter "UITests"
```

## Test Summary

| Category | Suites | Tests | Description |
|----------|--------|-------|-------------|
| **Unit Tests** | 19 | 60 | Detailed component behavior tests |
| **Smoke Tests** | 15 | 43 | Quick sanity checks for all features |
| **UI Tests** | 13 | 56 | SwiftUI view rendering & accessibility tests |
| **Total** | 47 | 159 | Full test coverage |

## Test Structure

```
Tests/
└── luxeUITests/
    ├── luxeUITests.swift    # Unit tests (60 tests)
    ├── SmokeTests.swift     # Smoke tests (43 tests)
    └── UITests.swift        # UI tests (56 tests)
```


## Running Tests in CI

Tests run automatically on every push and PR via GitHub Actions:

### Workflows

| Workflow | Trigger | What Runs |
|----------|---------|-----------|
| `swift.yml` | Push/PR | `swift build` + `swift test` |
| `tests.yml` | Push/PR | `swift test --parallel` |
| `smoke-tests.yml` | Push/PR | `swift test --filter SmokeTests --parallel` |

### CI Badges

![Swift CI](https://github.com/Ronitsabhaya75/Luxe-UI/actions/workflows/swift.yml/badge.svg)
![Tests](https://github.com/Ronitsabhaya75/Luxe-UI/actions/workflows/tests.yml/badge.svg)
![Smoke Tests](https://github.com/Ronitsabhaya75/Luxe-UI/actions/workflows/smoke-tests.yml/badge.svg)

## Writing New Tests

### Unit Test Example

```swift
import Testing
@testable import LuxeUI

@Suite("My Component Tests")
struct MyComponentTests {
    
    @Test("Default configuration has expected values")
    func defaultConfiguration() {
        let config = MyConfiguration.default
        
        #expect(config.size == 100)
        #expect(config.enabled == true)
    }
    
    @Test("Custom configuration works")
    func customConfiguration() {
        let config = MyConfiguration(size: 200, enabled: false)
        
        #expect(config.size == 200)
        #expect(config.enabled == false)
    }
}
```

### Smoke Test Example

```swift
@Suite("My Component Smoke Tests")
struct MyComponentSmokeTests {
    
    @Test("All presets exist")
    func presets() {
        let presets: [MyConfiguration] = [
            .default,
            .compact,
            .large
        ]
        
        #expect(presets.count == 3)
        
        for preset in presets {
            #expect(preset.size > 0)
        }
    }
    
    @Test("View can be instantiated")
    func viewInstantiation() {
        let view = MyComponent {
            Text("Content")
        }
        #expect(view != nil)
    }
}
```

### Best Practices

1. **Use descriptive test names** - Test names should describe what's being tested
2. **One assertion per concept** - Keep tests focused on a single behavior
3. **Test all presets** - Ensure every configuration preset is covered
4. **Test edge cases** - Include boundary conditions and invalid inputs
5. **Keep tests fast** - Avoid slow operations; use mocks when needed

## Test Categories

### Configuration Tests
Test that configuration structs:
- Have valid default values
- Support custom initialization
- Have all documented presets

### View Tests
Test that SwiftUI views:
- Can be instantiated with default config
- Can be instantiated with custom config
- Accept content builders correctly

### Integration Tests
Test that components:
- Can be nested within each other
- Receive theme from parent views
- Work with all theme presets

## Debugging Failed Tests

```bash
# Run with verbose output
swift test --verbose

# Run single failing test
swift test --filter "testName"

# Show test output on failure
swift test 2>&1 | tee test-output.log
```

## Code Coverage

To generate code coverage reports:

```bash
swift test --enable-code-coverage

# Find coverage data
xcrun llvm-cov report \
  .build/debug/luxeUIPackageTests.xctest/Contents/MacOS/luxeUIPackageTests \
  -instr-profile=.build/debug/codecov/default.profdata
```

## Contributing Tests

When adding new features:

1. **Add unit tests** in `luxeUITests.swift` for detailed behavior
2. **Add smoke tests** in `SmokeTests.swift` for quick validation
3. **Add UI tests** in `UITests.swift` for view rendering verification
4. **Run full suite** before submitting PR: `swift test`
5. **Ensure CI passes** - Check GitHub Actions status

---

## Complete Test List

### UI Tests (13 Suites, 56 Tests)

| Suite | Tests |
|-------|-------|
| **LuxeCard UI Tests** | LuxeCard renders with default configuration, LuxeCard renders with custom parameters, LuxeCard renders with all preset configurations, LuxeCard supports callback modifiers, LuxeCard renders with complex content |
| **GlassmorphismContainer UI Tests** | GlassmorphismContainer renders with default configuration, GlassmorphismContainer renders with custom parameters, GlassmorphismContainer renders with all presets, GlassmorphismContainer renders nested content |
| **RefractiveGlass UI Tests** | RefractiveGlass renders with all presets, RefractiveGlass renders with custom configuration, RefractiveGlass renders without chromatic aberration, RefractiveGlass modifier applies to view |
| **CircularProgressBar UI Tests** | CircularProgressBar renders at 0%, CircularProgressBar renders at 50%, CircularProgressBar renders at 100%, CircularProgressBar renders with all size presets, CircularProgressBar renders with all style presets, CircularProgressBar renders with custom colors, CircularProgressBar renders with glow effect, CircularProgressBar renders without percentage, CircularProgressBar static size helpers |
| **MultiThumbSlider UI Tests** | MultiThumbSlider renders with two thumbs, MultiThumbSlider renders with custom range, MultiThumbSlider renders with all presets, MultiThumbSlider renders without labels, MultiThumbSlider renders with custom colors, MultiThumbSlider supports callbacks |
| **SmartSpring UI Tests** | SmartSprings modifier applies to view, SmartSprings renders with all presets, SmartSprings with rotation enabled |
| **MagneticPull UI Tests** | MagneticPull modifier applies to view, MagneticPull renders with all presets |
| **PredictiveLayout UI Tests** | LuxeAdaptiveContainer renders with high probability, LuxeAdaptiveContainer renders with low probability, LuxeAdaptiveContainer renders with all presets |
| **Premium Components UI Tests** | LuxeButton renders with title, LuxeButton renders with different styles, LuxeButton renders with all sizes, LuxeBadge renders with all presets, LuxeBadge renders with custom colors, FloatingOrb renders with all presets, FloatingOrb renders with custom size, MeshGradientBackground renders, Animated components initialize correctly |
| **Theme Integration UI Tests** | Components render with default theme, Components render with all theme presets, Custom theme applies to components, Theme flows through component hierarchy, Nested components inherit theme |
| **Complex Layout UI Tests** | Dashboard layout renders correctly, Profile card layout renders correctly, Settings page layout renders correctly, Onboarding screen layout renders correctly |
| **Accessibility UI Tests** | Components are accessible |
| **Animation UI Tests** | Static animation preset disables animation |


