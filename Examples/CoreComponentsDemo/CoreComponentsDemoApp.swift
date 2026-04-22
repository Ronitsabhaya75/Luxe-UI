import SwiftUI
import LuxeUI

@main
struct CoreComponentsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 1000, idealWidth: 1200, minHeight: 800)
                .luxeToast()
        }
        .windowStyle(.hiddenTitleBar)
    }
}

struct ContentView: View {
    @State private var selectedTheme = "ocean"
    @State private var progress: Double = 0.65
    @State private var sliderValues: [Double] = [20, 80]
    @State private var isOrbAnimating = true
    
    // Theme data
    private let themes: [(id: String, name: String, colors: [Color])] = [
        ("default", "Default", [Color(red: 0.2, green: 0.3, blue: 0.8), Color(red: 0.4, green: 0.2, blue: 0.7)]),
        ("midnight", "Midnight", [Color(red: 0.4, green: 0.2, blue: 0.8), Color(red: 0.6, green: 0.2, blue: 0.6)]),
        ("sunset", "Sunset", [Color(red: 0.9, green: 0.3, blue: 0.4), Color(red: 0.9, green: 0.5, blue: 0.2)]),
        ("ocean", "Ocean", [Color(red: 0.0, green: 0.6, blue: 0.8), Color(red: 0.2, green: 0.8, blue: 0.7)]),
        ("forest", "Forest", [Color(red: 0.2, green: 0.7, blue: 0.4), Color(red: 0.4, green: 0.8, blue: 0.3)]),
        ("neon", "Neon", [Color(red: 1.0, green: 0.0, blue: 0.8), Color(red: 0.0, green: 1.0, blue: 0.8)]),
        ("monochrome", "Mono", [Color(white: 0.1), Color(white: 0.2)]),
        ("light", "Light", [Color(red: 0.85, green: 0.9, blue: 1.0), Color(red: 0.9, green: 0.85, blue: 1.0)])
    ]
    
    private var backgroundColors: [Color] {
        switch selectedTheme {
        case "default":
            return [Color(red: 0.2, green: 0.3, blue: 0.8), Color(red: 0.4, green: 0.2, blue: 0.7), Color(red: 0.0, green: 0.6, blue: 0.8)]
        case "midnight":
            return [Color(red: 0.4, green: 0.2, blue: 0.8), Color(red: 0.2, green: 0.4, blue: 0.9), Color(red: 0.6, green: 0.2, blue: 0.6)]
        case "sunset":
            return [Color(red: 0.9, green: 0.3, blue: 0.4), Color(red: 0.9, green: 0.5, blue: 0.2), Color(red: 0.7, green: 0.2, blue: 0.5)]
        case "ocean":
            return [Color(red: 0.0, green: 0.6, blue: 0.8), Color(red: 0.0, green: 0.4, blue: 0.6), Color(red: 0.2, green: 0.8, blue: 0.7)]
        case "forest":
            return [Color(red: 0.2, green: 0.7, blue: 0.4), Color(red: 0.1, green: 0.5, blue: 0.3), Color(red: 0.4, green: 0.8, blue: 0.3)]
        case "neon":
            return [Color(red: 1.0, green: 0.0, blue: 0.8), Color(red: 0.0, green: 1.0, blue: 0.8), Color(red: 0.8, green: 0.8, blue: 0.0)]
        case "monochrome":
            return [Color(white: 0.1), Color(white: 0.2), Color(white: 0.15)]
        case "light":
            return [Color(red: 0.85, green: 0.9, blue: 1.0), Color(red: 0.9, green: 0.85, blue: 1.0), Color(red: 1.0, green: 0.9, blue: 0.95)]
        default:
            return themes[0].colors
        }
    }
    
    var body: some View {
        ZStack {
            // Background
            MeshGradientBackground(colors: backgroundColors, configuration: .vibrant)
                .ignoresSafeArea()
            
            // Floating Orbs for depth
            if isOrbAnimating {
                FloatingOrb(size: 300, color: .white.opacity(0.15), configuration: FloatingOrbConfiguration(animationDuration: 15))
                    .offset(x: -400, y: -300)
                FloatingOrb(size: 500, color: .white.opacity(0.1), configuration: FloatingOrbConfiguration(animationDuration: 25))
                    .offset(x: 400, y: 300)
            }
            
            ScrollView {
                VStack(spacing: 40) {
                    // Header
                    VStack(spacing: 16) {
                        Text("LuxeUI Core Components")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundStyle(LinearGradient(colors: [.white, .white.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                            .shadow(color: backgroundColors[0].opacity(0.5), radius: 20)
                        
                        Text("The foundation of premium interfaces")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                    
                    VStack(spacing: 32) {
                        ButtonsSection()
                        CardsSection()
                        ToastSection()
                        ProgressSection(progress: $progress, sliderValues: $sliderValues)
                        ThemeSection(themes: themes, selectedTheme: $selectedTheme)
                    }
                    .frame(maxWidth: 1000)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 80)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Subviews

struct ButtonsSection: View {
    var body: some View {
        GlassmorphismContainer(configuration: .frosted) {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(title: "Buttons & Badges", badge: "Interactive")
                
                HStack(spacing: 20) {
                    LuxeButton("Primary Button", style: .primary) {}
                    LuxeButton("Secondary", style: .secondary) {}
                    LuxeButton("Glass", style: .glass) {}
                    LuxeButton("Custom", style: .custom(background: [.orange, .red], foreground: .white, shadowColor: .orange)) {}
                }
                
                Divider().background(Color.white.opacity(0.2))
                
                HStack(spacing: 16) {
                    Text("Badges:")
                        .foregroundColor(.white.opacity(0.8))
                    LuxeBadge("New", color: .blue)
                    LuxeBadge("Featured", color: .purple)
                    LuxeBadge("Pro", color: .orange)
                    LuxeBadge("Success", color: .green)
                }
            }
            .padding(28)
        }
    }
}

struct CardsSection: View {
    var body: some View {
        GlassmorphismContainer(configuration: .frosted) {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(title: "Glass Cards", badge: "Layout")
                
                HStack(spacing: 20) {
                    LuxeCard(configuration: LuxeCardConfiguration(blur: 20, backgroundOpacity: 0.2)) {
                        VStack(alignment: .leading, spacing: 12) {
                            Image(systemName: "wand.and.stars")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            Text("Premium Effect")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("High quality blur with frosted glass effect.")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .onTap { print("Premium Effect card tapped") }
                    
                    LuxeCard(configuration: LuxeCardConfiguration(blur: 10, backgroundOpacity: 0.4)) {
                        VStack(alignment: .leading, spacing: 12) {
                            Image(systemName: "shield.check.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            Text("Secure & Fast")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Optimized for performance and security.")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .onTap { print("Secure & Fast card tapped") }
                    
                    LuxeCard(configuration: LuxeCardConfiguration(blur: 30, backgroundOpacity: 0.1)) {
                        VStack(alignment: .leading, spacing: 12) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            Text("Refractive")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Subtle refraction for realistic depth.")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .onTap { print("Refractive card tapped") }
                }
            }
            .padding(28)
        }
    }
}

struct ProgressSection: View {
    @Binding var progress: Double
    @Binding var sliderValues: [Double]
    
    var sliderRange: String {
        let sorted = sliderValues.sorted()
        if sorted.count >= 2 {
            return "\(Int(sorted[0])) - \(Int(sorted[1]))"
        }
        return ""
    }
    
    var body: some View {
        GlassmorphismContainer(configuration: .frosted) {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(title: "Progress & Metrics", badge: "Visuals")
                
                HStack(spacing: 40) {
                    // Circular Progress
                    VStack(spacing: 16) {
                        CircularProgressBar(
                            progress: progress,
                            size: 120,
                            lineWidth: 12,
                            colors: [.white, .white.opacity(0.8)]
                        )
                        .overlay(
                            Text("\(Int(progress * 100))%")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        )
                        
                        HStack {
                            Button("-") { withAnimation { progress = max(0, progress - 0.1) } }
                            Text("Progress")
                            Button("+") { withAnimation { progress = min(1, progress + 0.1) } }
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    
                    Divider().background(Color.white.opacity(0.2))
                    
                    // Range Slider
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Range Slider")
                            .foregroundColor(.white)
                        
                        MultiThumbSlider(
                            values: $sliderValues,
                            range: 0...100,
                            configuration: MultiThumbSliderConfiguration(
                                trackHeight: 6,
                                thumbSize: 24,
                                trackColor: Color.white.opacity(0.2),
                                thumbColor: .white
                            )
                        )
                        .frame(height: 40)
                        
                        Text("Selected: \(sliderRange)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(28)
        }
    }
}

struct ThemeSection: View {
    let themes: [(id: String, name: String, colors: [Color])]
    @Binding var selectedTheme: String
    
    var body: some View {
        GlassmorphismContainer(configuration: .frosted) {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(title: "Theme System", badge: "Dynamic")
                ThemeList(themes: themes, selectedTheme: $selectedTheme)
            }
            .padding(28)
        }
    }
}

struct ThemeList: View {
    let themes: [(id: String, name: String, colors: [Color])]
    @Binding var selectedTheme: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(themes, id: \.id) { theme in
                    ThemeButton(
                        name: theme.name,
                        colors: theme.colors,
                        isSelected: selectedTheme == theme.id
                    )
                    .onTapGesture {
                        withAnimation { selectedTheme = theme.id }
                        TactileFeedback.light()
                    }
                }
            }
        }
    }
}

struct ToastSection: View {
    @Environment(\.luxeToastManager) var toast
    
    var body: some View {
        GlassmorphismContainer(configuration: .frosted) {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(title: "Toast Notifications", badge: "New")
                
                Text("Tap a button to trigger a toast notification")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                
                HStack(spacing: 16) {
                    LuxeButton("Success", style: .custom(
                        background: [.green, .mint],
                        foreground: .white,
                        shadowColor: .green
                    )) {
                        toast.show("Changes saved!", style: .success)
                    }
                    
                    LuxeButton("Error", style: .custom(
                        background: [.red, .orange],
                        foreground: .white,
                        shadowColor: .red
                    )) {
                        toast.show("Upload failed", message: "Please check your connection and try again.", style: .error, configuration: .prominent)
                    }
                    
                    LuxeButton("Warning", style: .custom(
                        background: [.orange, .yellow],
                        foreground: .white,
                        shadowColor: .orange
                    )) {
                        toast.show("Low storage", message: "Only 2 GB remaining.", style: .warning)
                    }
                    
                    LuxeButton("Info", style: .glass) {
                        toast.show("Update available", message: "Version 2.0 is ready to install.", style: .info, configuration: .persistent)
                    }
                }
                
                HStack(spacing: 16) {
                    LuxeButton("Dismiss All", style: .secondary) {
                        toast.dismissAll()
                    }
                }
            }
            .padding(28)
        }
    }
}

// Helper Views
struct HeaderView: View {
    let title: String
    let badge: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            LuxeBadge(badge, color: .white.opacity(0.2))
        }
    }
}

struct ThemeButton: View {
    let name: String
    let colors: [Color]
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 80, height: 60)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: isSelected ? 3 : 0)
                )
                .shadow(color: isSelected ? .white.opacity(0.3) : .clear, radius: 10)
            
            Text(name)
                .font(.caption.bold())
                .foregroundColor(.white)
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(), value: isSelected)
    }
}
