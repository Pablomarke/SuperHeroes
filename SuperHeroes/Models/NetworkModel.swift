//
//  NetworkModel.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 18/9/23.
//

import Foundation

final class NetworkModel {
    
    enum NetworkError: Error {
        case unknown
        case malformedUrl
        case loginString
        case decodingFailed
        case noData
        case statusCode(code: Int?)
    }
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    func login(
        user: String,
        password: String,
        completion: @escaping (String?, Error?) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            return
        }
        
        // user:password lo estamos codificando
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)",
                         forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data else {
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                return
            }
            
            completion(token, nil)
        }
    }
}
