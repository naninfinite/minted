//
//  HealthStats.swift
//  Minted
//
//  MARK: - Purpose
//  Holds the plant's four health metrics as 0-100 values with clamping.
//  This is UI-agnostic data used to drive the avatar mood and info displays.
//
//  Notes:
//  - Keep the struct simple: data + small helpers. No storage logic here.
//  - Ranges are enforced so downstream UI never needs to guard.
//
//  Future:
//  - Adjust helpers (e.g., watering increases hydration and vigor slightly).
//  - Add derived mood mapping (Healthy / Okay / Needs Care) if needed.
//

import Foundation

/// A tiny value-type container for the plant's health metrics.
/// All fields are guaranteed to stay in 0...100 after init and changes.
public struct HealthStats: Equatable, Codable, Hashable {
    public private(set) var hydration: Int  // 0-100
    public private(set) var vigor: Int      // 0-100
    public private(set) var growth: Int     // 0-100
    public private(set) var light: Int      // 0-100
    
    /// Clamps any integer into the allowed 0...100 range.
    @inline(__always)
    private static func clamp(_ value: Int) -> Int {
        return max(0, min(100, value))
    }
    
    /// Designed initialiser with clamping.
    public init(hydration: Int, vigor: Int, growth: Int, light: Int) {
        self.hydration = Self.clamp(hydration)
        self.vigor = Self.clamp(vigor)
        self.growth = Self.clamp(growth)
        self.light = Self.clamp(light)
    }
    
    ///  Convenience initialiser: start with a neutral baseline (all 50).
    public static var neutral: HealthStats {
        HealthStats(hydration: 50, vigor: 50, growth: 50, light: 50)
    }
    
    // MARK: - Mutation helpers (still clamped)
    
    /// Returns a copy with hydration adjusted by delta and clamped.
    public func adjustingHydration(by delta: Int) -> HealthStats {
        var copy = self
        copy.hydration = Self.clamp(copy.hydration + delta)
        return copy
    }
    
    /// Returns a copy with light adjusted by delta and clamped.
    public func adjustingLight(by delta: Int) -> HealthStats {
        var copy = self
        copy.light = Self.clamp(copy.light + delta)
        return copy
    }
    
    /// Returns a copy with vigor adjusted by delta and clamped.
    public func adjustingVigor(by delta: Int) -> HealthStats {
        var copy = self
        copy.vigor = Self.clamp(copy.vigor + delta)
        return copy
    }
    
    /// Returns a copy with growth adjusted by delta and clamped.
    public func adjustingGrowth(by delta: Int) -> HealthStats {
        var copy = self
        copy.growth = Self.clamp(copy.growth + delta)
        return copy
    }
    
}
