//
//  Heroes.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 7/9/23.
//

import Foundation

// MARK: - Heroes

struct Heroes: Codable {
    let heroes: [Heroe]
    
    enum CodingKeys: CodingKey {
        case heroes
    }
}

// MARK: - Heroe
struct Heroe: Codable {
    let id, description, name, photo: String
    let favorite: Bool
    
    enum CodingKeys: CodingKey {
        case photo
        case id
        case description
        case name
        case favorite
    }
}


