import SwiftUI
import LuxeUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var progress: Double = 0.65
    @State private var isAnimating = true
    @State private var blobScale: CGFloat = 1.0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: Liquid Blob Effects
            VStack(spacing: 20) {
                Text("GPU Liquid Blob Effects")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
              
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 40) {
                        // Liquid Blob 1
                        LiquidBlob()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.cyan, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 150, height: 150)
                            .scaleEffect(blobScale)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                                    blobScale = 1.2
                                }
                            }
                        
                        // Liquid Blob 2
                        LiquidBlob()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.pink, .red]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 120, height: 120)
                            .rotationEffect(.degrees(isAnimating ? 360 : 0))
                            .onAppear {
                                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                                    isAnimating = true
                                }
                            }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .tag(0)
            
            // Tab 2: Refractive Glass Effects
            VStack(spacing: 20) {
                Text("GPU Refractive Glass")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Glass Card 1
                        RefractiveGlassModifier(
                            content: {
                                VStack(spacing: 12) {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 32))
                                        .foregroundColor(.yellow)
                                    Text("Glassmorphism")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text("GPU-Accelerated Effects")
                                        .font(.caption)
                                        .opacity(0.8)
                                }
                                .frame(height: 150)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                            }
                        )
                        .frame(height: 180)
                        .cornerRadius(15)
                        .padding()
                        
                        // Glass Card 2
                        RefractiveGlassModifier(
                            content: {
                                VStack(spacing: 12) {
                                    Image(systemName: "bolt.fill")
                                        .font(.system(size: 32))
                                        .foregroundColor(.orange)
                                    Text("Metal Shaders")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text("High Performance Rendering")
                                        .font(.caption)
                                        .opacity(0.8)
                                }
                                .frame(height: 150)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                            }
                        )
                        .frame(height: 180)
                        .cornerRadius(15)
                        .padding()
                        
                        // Glass Card 3
                        RefractiveGlassModifier(
                            content: {
                                VStack(spacing: 12) {
                                    Image(systemName: "sparkles")
                                        .font(.system(size: 32))
                                        .foregroundColor(.cyan)
                                    Text("Distortion Effects")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text("Real-time GPU Processing")
                                        .font(.caption)
                                        .opacity(0.8)
                                }
                                .frame(height: 150)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                            }
                        )
                        .frame(height: 180)
                        .cornerRadius(15)
                        .padding()
                    }
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.indigo, .purple, .pink]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                )
            }
            .tag(1)
            
            // Tab 3: Progress & Loading
            VStack(spacing: 30) {
                Text("GPU Progress & Loading")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                VStack(spacing: 40) {
                    // Liquid Progress
                    VStack(spacing: 8) {
                        Text("Liquid Progress: \(Int(progress * 100))%")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        LiquidProgress(value: $progress)
                            .frame(height: 100)
                            .cornerRadius(15)
                    }
                    .padding()
                    
                    // Liquid Loader
                    VStack(spacing: 12) {
                        Text("Loading Animation")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        LiquidLoader(isAnimating: $isAnimating)
                            .frame(width: 100, height: 100)
                    }
                    .padding()
                    
                    // Control Buttons
                    HStack(spacing: 15) {
                        Button(action: {
                            progress = max(0, progress - 0.1)
                        }) {
                            Label("Decrease", systemImage: "minus.circle.fill")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.7))
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            progress = min(1, progress + 0.1)
                        }) {
                            Label("Increase", systemImage: "plus.circle.fill")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green.opacity(0.7))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                
                Spacer()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.teal, .cyan, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .tag(2)
            
            // Tab 4: Buttons & Interactions
            VStack(spacing: 20) {
                Text("GPU Interactive Buttons")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Liquid Button 1
                        LiquidButton(
                            title: "Tap Me",
                            backgroundColor: .blue,
                            action: {
                                print("Button 1 tapped!")
                            }
                        )
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .cornerRadius(12)
                        .padding()
                        
                        // Liquid Button 2
                        LiquidButton(
                            title: "GPU Render",
                            backgroundColor: .purple,
                            action: {
                                print("Button 2 tapped!")
                            }
                        )
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .cornerRadius(12)
                        .padding()
                        
                        // Liquid Button 3
                        LiquidButton(
                            title: "Metal Shader",
                            backgroundColor: .pink,
                            action: {
                                print("Button 3 tapped!")
                            }
                        )
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .cornerRadius(12)
                        .padding()
                        
                        // Liquid Button 4
                        LiquidButton(
                            title: "Accelerated",
                            backgroundColor: .orange,
                            action: {
                                print("Button 4 tapped!")
                            }
                        )
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .cornerRadius(12)
                        .padding()
                        
                        Spacer()
                    }
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.orange, .red, .pink]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                )
            }
            .tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
