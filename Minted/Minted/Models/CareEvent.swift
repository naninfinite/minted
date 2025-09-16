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

