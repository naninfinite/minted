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
