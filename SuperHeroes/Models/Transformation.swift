//
//  Transformation.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 18/9/23.
//

import Foundation

struct Transformation: Decodable {
    let name, id, description : String
    let photo: URL
    
}

extension Transformation: CellRepresentable {
    
}
