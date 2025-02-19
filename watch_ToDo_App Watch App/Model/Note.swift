//
//  Note.swift
//  watch_ToDo_App
//
//  Created by english on 2025-02-19.
//

import Foundation

// struct -> Identifiable, codeable (JSON/decode)
// id -> UUID
// text -> String

struct Note: Identifiable, Codable {
    var id: UUID
    var text: String
}
