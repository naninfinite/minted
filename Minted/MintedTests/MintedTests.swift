//
//  MintedTests.swift
//  MintedTests
//
//  Created by NaNinfinite on 16/09/2025.
//

import XCTest
@testable import Minted

final class MintedTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCareEventSummaryIncludesVerbAndDate() {
        let when = Date(timeIntervalSince1970: 0) // 1 Jan 1970 UTC; deterministic
        let e = CareEvent(type: .water, date: when, note: "Top dry")
        let s = e.summary
        XCTAssertTrue(s.contains("Watered"))
        XCTAssertTrue(s.contains("Top dry"))
        // Date string is locale-dependent, so we only assert pieces we control.
    }
    
    func testOverallBandThresholds() {
        XCTAssertEqual(HealthStats(hydration: 80, vigor: 78, growth: 76, light: 90).overallBand, .healthy)
        XCTAssertEqual(HealthStats(hydration: 50, vigor: 55, growth: 48, light: 60).overallBand, .okay)
        XCTAssertEqual(HealthStats(hydration: 20, vigor: 35, growth: 25, light: 30).overallBand, .needsCare)
    }

}
