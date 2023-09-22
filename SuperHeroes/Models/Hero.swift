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

extension Hero: CellRepresentable {
}

/*
 MARK: Decodable manual
extension Hero: Decodable {
    enum CodingKeys: String, CodingKey {
        case photo
        case id
        case description
        case name
        case favourite = "favorite"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self,
                               forKey: .id)
        name = try values.decode(String.self,
                                 forKey: .name)
        description = try values.decode(String.self,
                                        forKey: .description)
        photo = try values.decode(String.self,
                                  forKey: .photo)
        favourite = try values.decode(Bool.self,
                                      forKey: .favourite)
    }
}
*/
