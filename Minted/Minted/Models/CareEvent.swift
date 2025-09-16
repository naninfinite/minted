//
//  CareEvent.swift
//  Minted
//
//  MARK: - Purpose
//  Defines the immutable record of a plant care action (water/prune/repot).
//  Stored as part of history; drives stats, schedules, and photo log snapshots.
//
//  Inputs: user actions (tag log buttons) or future watch/widget intents
//  Outputs: serialisable log entries for persistence and history views
//  Dependencies: Foundation only (Codable/Date)
//  Future: optional link to a photo (by local identifier or file URL)

import Foundation

/// The type of care action recorded in the log.
public enum CareType: String, Codable, CaseIterable, Identifiable {
    case water = "Water"
    case prune = "Prune"
    case repot = "Repot"
    
    public var id: String { rawValue }
    
    /// A short, human-friendly verb for UI copy.
    public var verb: String {
        switch self {
        case .water: return "Watered"
        case .prune: return "Pruned"
        case .repot: return "Repotted"
        }
    }
    
    /// A succinct SF Symbol name suggestion for buttons/lists.
    public var symbolName: String {
        switch self {
        case .water: return "drop"
        case .prune: return "scissors"
        case .repot: return "arrow.triangle.2.circlepath"
        }
    }
}

