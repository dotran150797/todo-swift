//
//  Todo.swift
//  tudu-app
//
//  Created by Do Tran on 26/2/25.
//
import SwiftUI

struct Todo: Decodable, Identifiable {
    let id: String
    let title: String
    let description: String
    var isCompleted: Bool
    let createdAt: String
    
    var priority: Priority
    var category: Category
    let creationTime: Double? // Optional: handle _creationTime if needed

    // Nested enum for priority
    enum Priority: Int, Decodable {
        case none = 0  // Added to handle 0 from JSON
        case low = 1
        case medium = 2
        case high = 3
        
        init(from decoder: Decoder) throws {
            let value = try decoder.singleValueContainer().decode(Int.self)
            self = Priority(rawValue: value) ?? .none // Default to none if invalid
        }
    }
    
    // Nested enum for category (updated to handle integers)
    enum Category: Int, Decodable { // Changed from String to Int
        case other = 0    // Maps 0 to "Other"
        case personal = 1 // Maps 1 to "Personal"
        case work = 2     // Maps 2 to "Work"
        
        // Provide string representation for UI
        var stringValue: String {
            switch self {
            case .personal: return "Personal"
            case .work: return "Work"
            case .other: return "Other"
            }
        }
        
        init(from decoder: Decoder) throws {
            let value = try decoder.singleValueContainer().decode(Int.self)
            self = Category(rawValue: value) ?? .other // Default to other if invalid
        }
    }
    
    var createdAtTimestamp: Double? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Matches "2025-02-26 23:00:07"
        if let date = formatter.date(from: createdAt) {
            return date.timeIntervalSince1970
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case isCompleted
        case createdAt
        case priority
        case category
        case creationTime = "_creationTime" // Map _creationTime if needed
    }
}
