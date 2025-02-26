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
    let isCompleted: Bool
    let createdAt: Date
    
    var priority: Priority
    let category: Category

    // Nested enum for priority
    enum Priority: Int, Decodable {
        case low = 1
        case medium = 2
        case high = 3
        
        init(from decoder: Decoder) throws {
            let value = try decoder.singleValueContainer().decode(Int.self)
            self = Priority(rawValue: value) ?? .medium // Default to medium if invalid
        }
    }
    
    // Nested struct or enum for category
    enum Category: String, Decodable {
        case personal = "Personal"
        case work = "Work"
        case other = "Other"
        
        init(from decoder: Decoder) throws {
            let value = try decoder.singleValueContainer().decode(String.self)
            self = Category(rawValue: value) ?? .other // Default to other if invalid
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case isCompleted
        case createdAt
        case priority
        case category
    }
}

