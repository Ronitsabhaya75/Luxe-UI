import SwiftUI
import LuxeUI

@main
struct FormInputsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isNotificationsEnabled = true
    @State private var isMarketingEnabled = false
    @State private var agreedToTerms = false
    @State private var selectedTheme = "midnight"
    @State private var volume: Double = 75
    @State private var brightness: Double = 60
    
    // Theme data with colors and emojis
    private let themes: [(id: String, name: String, emoji: String, colors: [Color])] = [
        ("default", "Default", "", [Color(red: 0.2, green: 0.3, blue: 0.8), Color(red: 0.4, green: 0.2, blue: 0.7)]),
        ("midnight", "Midnight", "", [Color(red: 0.4, green: 0.2, blue: 0.8), Color(red: 0.6, green: 0.2, blue: 0.6)]),
        ("sunset", "Sunset", "", [Color(red: 0.9, green: 0.3, blue: 0.4), Color(red: 0.9, green: 0.5, blue: 0.2)]),
        ("ocean", "Ocean", "", [Color(red: 0.0, green: 0.6, blue: 0.8), Color(red: 0.2, green: 0.8, blue: 0.7)]),
        ("forest", "Forest", "", [Color(red: 0.2, green: 0.7, blue: 0.4), Color(red: 0.4, green: 0.8, blue: 0.3)]),
        ("neon", "Neon", "", [Color(red: 1.0, green: 0.0, blue: 0.8), Color(red: 0.0, green: 1.0, blue: 0.8)]),
        ("monochrome", "Mono", "", [Color(white: 0.1), Color(white: 0.2)]),
        ("light", "Light", "", [Color(red: 0.85, green: 0.9, blue: 1.0), Color(red: 0.9, green: 0.85, blue: 1.0)])
    ]
    
    // Computed property for background colors based on theme
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
            return [Color(red: 0.4, green: 0.2, blue: 0.8), Color(red: 0.2, green: 0.4, blue: 0.9), Color(red: 0.6, green: 0.2, blue: 0.6)]
        }
    }
    
    var body: some View {
        ZStack {
            // Dynamic Mesh Gradient Background
            MeshGradientBackground(colors: backgroundColors, configuration: .vibrant)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.8), value: selectedTheme)
            
            ScrollView {
                VStack(spacing: 40) {
                    // Header
                    VStack(spacing: 12) {
                        Text("LuxeUI Form Inputs")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.white, Color(red: 0.8, green: 0.9, blue: 1.0)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(color: .blue.opacity(0.5), radius: 20)
                        
                        Text("Premium form components with glassmorphism")
                            .font(.system(size: 17))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.top, 50)
                    
                    // VISUAL THEME PICKER - ALL 8 THEMES
                    VStack(spacing: 16) {
                        Text("Background Themes")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("All 8 built-in LuxeUI themes")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.7))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(themes, id: \.id) { theme in
                                    ThemeCard(
                                        name: theme.name,
                                        emoji: theme.emoji,
                                        colors: theme.colors,
                                        isSelected: selectedTheme == theme.id
                                    )
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            selectedTheme = theme.id
                                        }
                                        TactileFeedback.light()
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    // Text Fields Section
                    GlassmorphismContainer(configuration: .frosted) {
                        VStack(alignment: .leading, spacing: 24) {
                            HStack {
                                Text("Text Fields")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                LuxeBadge("NEW", color: .cyan)
                            }
                            
                            LuxeTextField(
                                "Username",
                                text: $username,
                                icon: Image(systemName: "person.fill"),
                                configuration: LuxeTextFieldConfiguration(
                                    activeBorderColor: Color(red: 0.4, green: 0.6, blue: 1.0)
                                )
                            )
                            
                            LuxeTextField(
                                "Email Address",
                                text: $email,
                                icon: Image(systemName: "envelope.fill"),
                                configuration: LuxeTextFieldConfiguration(
                                    activeBorderColor: Color(red: 0.6, green: 0.4, blue: 1.0)
                                )
                            )
                            
                            LuxeTextField(
                                "Password",
                                text: $password,
                                icon: Image(systemName: "lock.fill"),
                                configuration: LuxeTextFieldConfiguration(
                                    activeBorderColor: Color(red: 0.8, green: 0.3, blue: 0.9)
                                )
                            )
                            .secure(true)
                        }
                        .padding(28)
                    }
                    .padding(.horizontal, 20)
                    
                    // Toggles Section
                    GlassmorphismContainer(configuration: .vibrant) {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Toggles")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Enable Notifications")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text("Get alerts for important updates")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                Spacer()
                                LuxeToggle(
                                    isOn: $isNotificationsEnabled,
                                    configuration: LuxeToggleConfiguration(
                                        onColor: Color(red: 0.3, green: 0.8, blue: 0.5)
                                    )
                                )
                            }
                            
                            Divider().background(Color.white.opacity(0.2))
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Marketing Emails")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text("Receive promotional content")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                Spacer()
                                LuxeToggle(
                                    isOn: $isMarketingEnabled,
                                    configuration: LuxeToggleConfiguration(
                                        onColor: Color(red: 0.9, green: 0.4, blue: 0.6)
                                    )
                                )
                            }
                        }
                        .padding(28)
                    }
                    .padding(.horizontal, 20)
                    
                    // Checkboxes
                    GlassmorphismContainer(configuration: .frosted) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Agreement")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 14) {
                                LuxeCheckbox(
                                    isOn: $agreedToTerms,
                                    configuration: LuxeCheckboxConfiguration(
                                        activeColor: Color(red: 0.3, green: 0.8, blue: 0.9)
                                    )
                                )
                                Text("I agree to the Terms and Conditions")
                                    .font(.system(size: 15))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                        .padding(28)
                    }
                    .padding(.horizontal, 20)
                    
                    // Sliders Section
                    GlassmorphismContainer(configuration: .vibrant) {
                        VStack(alignment: .leading, spacing: 28) {
                            HStack {
                                Text("Slider Controls")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                LuxeBadge("DEMO", color: .purple)
                            }
                            
                            Text("Interactive sliders - drag or tap to adjust")
                                .font(.system(size: 13))
                                .foregroundColor(.white.opacity(0.7))
                            
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    HStack(spacing: 8) {
                                        Image(systemName: "speaker.wave.2.fill")
                                            .foregroundColor(.cyan)
                                            .font(.system(size: 18))
                                        Text("Volume")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    Text("\(Int(volume))%")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [.cyan, .blue],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                }
                                
                                LuxeSlider(
                                    value: $volume,
                                    range: 0...100,
                                    step: 1,
                                    configuration: LuxeSliderConfiguration(
                                        trackHeight: 8,
                                        thumbSize: 28,
                                        activeTrackColor: Color(red: 0.3, green: 0.7, blue: 1.0),
                                        showValueLabel: true
                                    )
                                )
                            }
                            
                            Divider().background(Color.white.opacity(0.2))
                            
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    HStack(spacing: 8) {
                                        Image(systemName: "sun.max.fill")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 18))
                                        Text("Brightness")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    Text("\(Int(brightness))%")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [.orange, .yellow],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                }
                                
                                LuxeSlider(
                                    value: $brightness,
                                    range: 0...100,
                                    step: 5,
                                    configuration: LuxeSliderConfiguration(
                                        trackHeight: 8,
                                        thumbSize: 28,
                                        activeTrackColor: Color(red: 1.0, green: 0.6, blue: 0.2),
                                        showValueLabel: true
                                    )
                                )
                            }
                        }
                        .padding(28)
                    }
                    .padding(.horizontal, 20)
                    
                    // Submit Button
                    LuxeButton("Submit Form", style: .primary, configuration: .large) {
                        print("✨ Form submitted!")
                        print("Username: \(username)")
                        print("Email: \(email)")
                        print("Theme: \(selectedTheme)")
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 60)
                }
            }
        }
    }
}

// MARK: - Theme Card Component
struct ThemeCard: View {
    let name: String
    let emoji: String
    let colors: [Color]
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            // LuxeCard with gradient background
            ZStack {
                // Gradient background
                LinearGradient(
                    colors: colors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .cornerRadius(20)
                
                // Glassmorphism overlay using LuxeCard
                LuxeCard(
                    configuration: LuxeCardConfiguration(
                        cornerRadius: 20,
                        blur: 12,
                        backgroundOpacity: 0.3,
                        borderWidth: isSelected ? 3 : 1.5,
                        borderOpacity: isSelected ? 0.8 : 0.4,
                        shadowRadius: isSelected ? 16 : 8,
                        hoverScale: 1.0,
                        pressScale: 1.0
                    )
                ) {
                    Color.clear
                        .frame(width: 100, height: 80)
                }
                .allowsHitTesting(false)
            }
            .frame(width: 100, height: 80)
            .shadow(color: isSelected ? .white.opacity(0.4) : .clear, radius: 16)
            
            Text(name)
                .font(.system(size: 14, weight: isSelected ? .bold : .medium))
                .foregroundColor(.white)
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
