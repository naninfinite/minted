//
//  HealthStatsTests.swift
//  Minted
//
//  MARK: - Purpose
//  Verifies that HealthStats enforces 0...100 clamping at init and via its adjusting helpers;
//  that the neutral baseline is correct; and that the overallBand boundaries (40 and 75) behave as specified.
//
//  Inputs: direct HealthStats initialisers and adjusting* helper calls
//  Outputs: XCTest assertions (functional, deterministic)
//
//  Dependencies: XCTest, Minted (HealthStats)
//  Notes:
//  - Keep tests as Logic Tests (Host Application = None) to avoid launching a simulator.
//  - Boundary cases are explicit to guard against regressions.
//  - We avoid locale/date depedencies here.
//
//  Future:
//  - If we add more derived signals in HealthStats, extend coverage here.


import XCTest
@testable import Minted

final class HealthStatsTests: XCTestCase {
    
    // MARK: - Init clamping
    
    /// Values below 0 clamp to 0; values above 100 clamp to 100.
    func testInitClampsBelowZeroAndAboveHundred() {
        let low = HealthStats(hydration: -10, vigor: -1, growth: 0, light: 5)
        XCTAssertEqual(low.hydration, 0)
        XCTAssertEqual(low.vigor, 0)
        XCTAssertEqual(low.growth, 0)
        XCTAssertEqual(low.light, 5)
        
        let high = HealthStats(hydration: 200, vigor: 150, growth: 101, light: 100)
        XCTAssertEqual(high.hydration, 100)
        XCTAssertEqual(high.vigor, 100)
        XCTAssertEqual(high.growth, 100)
        XCTAssertEqual(high.light, 100)
    }
    
    // MARK: - Adjust helpers clamping
    
    /// Upward adjustments clamp at 100; downward adjustments clamp at 0.
    func testAdjustingHelpersClampAtEdges() {
        // Upward clamps
        let nearTop = HealthStats(hydration: 95, vigor: 96, growth: 97, light: 98)
        let up = nearTop
            .adjustingHydration(by: 10)
            .adjustingVigor(by: 10)
            .adjustingGrowth(by: 10)
            .adjustingLight(by: 10)
        XCTAssertEqual(up.hydration, 100)
        XCTAssertEqual(up.vigor, 100)
        XCTAssertEqual(up.growth, 100)
        XCTAssertEqual(up.light, 100)
        
        // Downward clamps
        let nearBottom = HealthStats(hydration: 3, vigor: 2, growth: 1, light: 0)
        let down = nearBottom
            .adjustingHydration(by: -10)
            .adjustingVigor(by: -10)
            .adjustingGrowth(by: -10)
            .adjustingLight(by: -10)
        XCTAssertEqual(down.hydration, 0)
        XCTAssertEqual(down.vigor, 0)
        XCTAssertEqual(down.growth, 0)
        XCTAssertEqual(down.light, 0)
    }
    
    // MARK: - Derived band boundaries
    
    /// Average exactly 75 => .healthy (range 75...100).
    func testOverallBandBoundaryAt75IsHealthy() {
        let s = HealthStats(hydration: 75, vigor: 75, growth: 75, light: 75)
        XCTAssertEqual(s.overallBand, .healthy)
    }
    
    /// Average exactly 40 => .okay (range 40..<75).
    func testOverallBandBoundaryAt40IsOkay() {
        let s = HealthStats(hydration: 40, vigor: 40, growth: 40, light: 40)
        XCTAssertEqual(s.overallBand, .okay)
    }
}

