#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// 1. Liquid Blob (Color Effect)
[[ stitchable ]] half4 liquidBlob(
    float2 position,
    half4 color,
    float2 size,
    float phase,
    float morphIntensity
) {
    float2 center = size * 0.5;
    float2 p = position - center;
    
    float angle = atan2(p.y, p.x);
    float radiusVariation = sin(angle * 3.0 + phase * 4.0 * M_PI_F) * morphIntensity;
    float baseRadius = min(size.x, size.y) * 0.5;
    float radius = baseRadius * (1.0 + radiusVariation);
    
    float d = length(p) - radius;
    float alpha = 1.0 - smoothstep(-1.0, 0.0, d); // softly alias
    
    return half4(color.rgb, color.a * alpha);
}

// 2. Caustic Light (Color Effect)
[[ stitchable ]] half4 causticLight(
    float2 position,
    half4 color,
    float2 size,
    float phase,
    float causticCount
) {
    float alphaAccumulator = 0.0;
    int count = int(causticCount);
    for(int i = 0; i < 20; i++) {
        if (i >= count) break;
        float progress = float(i) / causticCount;
        float cx = size.x * (0.2 + 0.6 * sin(phase + progress * M_PI_F * 2.0));
        float cy = size.y * (0.2 + 0.6 * cos(phase * 1.3 + progress * M_PI_F * 2.0));
        
        float causticSize = 30.0 + 20.0 * sin(phase * 2.0 + progress * M_PI_F);
        
        float2 p = position - float2(cx, cy);
        p.y /= 0.6; // Scale y to make an ellipse
        float dist = length(p);
        float radius = causticSize * 0.5;
        
        if(dist < radius) {
            float intensity = 1.0 - (dist / radius);
            float localAlpha = intensity > 0.5 ? mix(0.1, 0.3, (intensity - 0.5) * 2.0) : mix(0.0, 0.1, intensity * 2.0);
            alphaAccumulator += localAlpha;
        }
    }
    
    // We compose the white highlight with the original color
    // Additive blending locally before output
    half3 blend = half3(1.0) * alphaAccumulator;
    return half4(color.rgb + blend, max(color.a, half(alphaAccumulator)));
}

// 3. Chromatic Aberration (Layer Effect)
[[ stitchable ]] half4 chromaticAberration(
    float2 position,
    SwiftUI::Layer layer,
    float strength
) {
    float2 rOffset = float2(-strength, -strength);
    float2 gOffset = float2(0.0, 0.0);
    float2 bOffset = float2(strength, strength);
    
    half r = layer.sample(position + rOffset).r;
    half g = layer.sample(position + gOffset).g;
    half b = layer.sample(position + bOffset).b;
    half a = layer.sample(position).a; 
    
    return half4(r, g, b, a);
}

// 4. Liquid Wave (Color Effect)
[[ stitchable ]] half4 liquidWave(
    float2 position,
    half4 color,
    float2 size,
    float progress,
    float amplitude,
    float frequency,
    float phase
) {
    float baseHeight = size.y * (1.0 - progress);
    float relativeX = position.x / size.x;
    float sine = sin(relativeX * frequency * M_PI_F * 2.0 + phase);
    float y = baseHeight + sine * amplitude;
    
    if (position.y >= y) {
        return color;
    } else {
        return half4(0.0);
    }
}

// 5. Metaball Loader (Color Effect)
[[ stitchable ]] half4 metaballLoader(
    float2 position,
    half4 color,
    float2 size,
    float timeOffset,
    float circleCount,
    float scaleEffect
) {
    float2 center = size / 2.0;
    float orbitRadius = min(size.x, size.y) / 3.0;
    
    float d = 0.0;
    
    // Center blob
    float centerRadius = (size.x / 4.0) * 0.5;
    d += pow(centerRadius, 2.0) / max(dot(position - center, position - center), 0.001);
    
    int count = int(circleCount);
    for (int i = 0; i < 12; i++) {
        if (i >= count) break;
        
        float angle = (float(i) / circleCount) * 2.0 * M_PI_F;
        float currentAngle = angle + timeOffset;
        float2 blobPos = center + float2(cos(currentAngle), sin(currentAngle)) * orbitRadius;
        
        float pulse = sin(timeOffset * 2.0 + float(i)) * 0.2 + 1.0;
        float blobRadius = (size.x / 5.0 * scaleEffect * pulse) * 0.5;
        
        d += pow(blobRadius, 2.0) / max(dot(position - blobPos, position - blobPos), 0.001);
    }
    
    float alpha = smoothstep(0.8, 1.0, d);
    return half4(color.rgb, color.a * alpha);
}

// 6. Lens Distortion (Distortion Effect)
[[ stitchable ]] float2 lensDistortion(
    float2 position,
    float2 size,
    float intensity,
    float radius
) {
    float2 center = size / 2.0;
    float2 p = position - center;
    float dist = length(p);
    
    if (dist < radius && dist > 0.0) {
        float normalized = dist / radius;
        float perspective = 1.0 / (1.0 + intensity * 0.5);
        p = p * perspective; 
        
        float warped = pow(normalized, 1.0 + intensity);
        p = p * (warped / normalized);
    }
    
    return center + p;
}
