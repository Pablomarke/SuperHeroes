//
//  Heroes.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 7/9/23.
//

import Foundation

struct Hero: Decodable {
    let id, description, name : String
    let photo: URL
    let favorite: Bool
}

extension Hero: HeroesAndTransformations{
}
