import SwiftUI
import LuxeUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var intensity: Double = 0.5
    @State private var radius: CGFloat = 10.0
    @State private var animationProgress: Double = 0.0
    @State private var isAnimating = true
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.15, blue: 0.3),
                    Color(red: 0.05, green: 0.1, blue: 0.25)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("LuxeUI GPU Rendering")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Metal Shader Effects")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(Color.black.opacity(0.3))
                
                // Tab selector
                Picker("Effect", selection: $selectedTab) {
                    Text("Glass").tag(0)
                    Text("Blob").tag(1)
                    Text("Loader").tag(2)
                    Text("Progress").tag(3)
                }
                .pickerStyle(.segmented)
                .padding(12)
                
                // Content area
                TabView(selection: $selectedTab) {
                    // Tab 0: Refractive Glass
                    VStack(spacing: 16) {
                        Text("Refractive Glass Effect")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.blue.opacity(0.2))
                            
                            VStack(spacing: 12) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 48))
                                    .foregroundColor(.cyan)
                                Text("Glass Morphism")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Refraction + Caustics")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .frame(height: 200)
                        }
                        .refractiveGlass(intensity: intensity, radius: radius)
                        .frame(maxHeight: 250)
                        
                        Spacer()
                        
                        VStack(spacing: 8) {
                            HStack {
                                Text("Intensity")
                                    .foregroundColor(.white)
                                Slider(value: $intensity, in: 0...1)
                                    .tint(.cyan)
                                Text(String(format: "%.2f", intensity))
                                    .foregroundColor(.cyan)
                                    .frame(width: 40)
                            }
                            
                            HStack {
                                Text("Radius")
                                    .foregroundColor(.white)
                                Slider(value: $radius, in: 1...30)
                                    .tint(.cyan)
                                Text(String(format: "%.0f", radius))
                                    .foregroundColor(.cyan)
                                    .frame(width: 40)
                            }
                        }
                        .padding(12)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(8)
                    }
                    .tag(0)
                    
                    // Tab 1: Liquid Blob
                    VStack(spacing: 16) {
                        Text("Liquid Blob Effect")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.2, green: 0.8, blue: 1.0),
                                            Color(red: 0.0, green: 0.5, blue: 1.0)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            
                            VStack {
                                LiquidBlob(animationProgress: animationProgress)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                .cyan,
                                                .blue
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(maxWidth: 120, maxHeight: 120)
                            }
                        }
                        .frame(height: 250)
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Button(action: { isAnimating.toggle() }) {
                                Text(isAnimating ? "Pause" : "Play")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(Color.cyan.opacity(0.6))
                                    .cornerRadius(8)
                            }
                            .disabled(!isAnimating)
                            
                            Button(action: { animationProgress = 0 }) {
                                Text("Reset")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.4))
                                    .cornerRadius(8)
                            }
                        }
                        .padding(12)
                    }
                    .tag(1)
                    .onAppear {
                        startLiquidAnimation()
                    }
                    
                    // Tab 2: Liquid Loader
                    VStack(spacing: 16) {
                        Text("Liquid Loader Effect")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.purple.opacity(0.1))
                            
                            VStack(spacing: 24) {
                                LiquidLoader(animationProgress: animationProgress, color: .purple)
                                    .frame(width: 100, height: 100)
                                
                                Text("Loading...")
                                    .font(.caption)
                                    .foregroundColor(.purple)
                            }
                        }
                        .frame(height: 250)
                        
                        Spacer()
                        
                        Text("GPU-accelerated liquid animation using Metal shaders")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(12)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(8)
                    }
                    .tag(2)
                    .onAppear {
                        startLiquidAnimation()
                    }
                    
                    // Tab 3: Progress Bar
                    VStack(spacing: 16) {
                        Text("Circular Progress")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.green.opacity(0.1))
                            
                            VStack(spacing: 20) {
                                CircularProgressBar(
                                    progress: animationProgress,
                                    lineWidth: 8,
                                    gradient: LinearGradient(
                                        gradient: Gradient(colors: [.green, .cyan]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 120, height: 120)
                                
                                Text("\(Int(animationProgress * 100))%")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                        }
                        .frame(height: 250)
                        
                        Spacer()
                        
                        HStack {
                            Button(action: { animationProgress = max(0, animationProgress - 0.1) }) {
                                Text("−")
                                    .font(.system(size: 20, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(Color.red.opacity(0.6))
                                    .cornerRadius(8)
                            }
                            
                            Button(action: { animationProgress = min(1, animationProgress + 0.1) }) {
                                Text("+")
                                    .font(.system(size: 20, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(Color.green.opacity(0.6))
                                    .cornerRadius(8)
                            }
                        }
                        .foregroundColor(.white)
                        .padding(12)
                    }
                    .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxHeight: .infinity)
                .padding(12)
            }
        }
    }
    
    private func startLiquidAnimation() {
        guard isAnimating else { return }
        let timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            withAnimation(.linear(duration: 0.016)) {
                animationProgress += 0.01
                if animationProgress > 1.0 {
                    animationProgress = 0
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
