//
//  HeroesAndTransformations.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 22/9/23.
//

import Foundation

protocol HeroesAndTransformations {
    var name: String { get }
    var description: String { get }
    var id: String { get }
    var photo: URL { get }
}
