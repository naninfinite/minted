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
