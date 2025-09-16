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

/// An immutable record of a single care action.
/// This is the source of truth for history, stats snapshots, and scheduling.
public struct CareEvent: Identifiable, Codable, Hashable {
    /// Stable identifier for idempotency (e.g., if Watch sends duplicates).
    public var id: UUID
    
    /// The care action performed.
    public var type: CareType
    
    /// When the action happened (UTC-safe `Date`).
    public var date: Date
    
    /// Optional free-text note (e.g., "Leggy tips above node").
    public var note: String?
    
    /// Optional reference to a photo captured at this moment.
    /// - If you use Photos, store the PHAsset local identifier here.
    /// - If you store files yourself, use a file URL string.
    public var photoRef: String?
    
    public init(
        id: UUID = UUID(),
        type: CareType,
        date: Date = .init(),
        note: String? = nil,
        photoRef: String? = nil
    ) {
        self.id = id
        self.type = type
        self.date = date
        self.note = note
        self.photoRef = photoRef
    }
}

// MARK: - Convenience

public extension CareEvent {
    /// Returns a concise, user-facing summary (for toasts/history cells).
    var summary: String {
        if let note, !note.isEmpty {
            return "\(type.verb) - \(formattedDate) · \(note)"
        } else {
            return "\(type.verb) - \(formattedDate)"
        }
    }
    
    /// Localised date string suitable for UI (Medium date, Short time).
    var formattedDate: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df.string(from: date)
    }
}
