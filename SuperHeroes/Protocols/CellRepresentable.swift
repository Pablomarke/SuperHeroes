//
//  CellRepresentable.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 22/9/23.
//

import Foundation

protocol CellRepresentable {
    var name: String { get }
    var description: String { get }
    var photo: URL { get }
}
