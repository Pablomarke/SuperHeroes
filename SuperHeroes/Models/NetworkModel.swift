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
        case encodingfailed
        case decodingFailed
        case noData
        case statusCode(code: Int?)
        case noToken
    }
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private var token: String?
    
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            completion(.failure(.malformedUrl))
            return
        }
        
        // user:password lo estamos codificando
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.decodingFailed))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)",
                         forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else {
                completion(.failure(.unknown))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            let urlResponse = response as? HTTPURLResponse
            let statusCode = urlResponse?.statusCode
            
            guard statusCode == 200 else {
                completion(.failure(.statusCode(code: statusCode)))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion(.failure(.decodingFailed))
                return
            }
            
            completion(.success(token))
            self?.token = token
        }
        
        task.resume()
    }
    
    func getHeroes(
        token: String,
        completion: @escaping (Result<[Hero],
                               NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else {
            completion(.failure(.malformedUrl))
            return
        }
        /*
         guard let token else {
         completion([], .noToken)
         return
         }
         */
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = urlComponents.query?.data(using: .utf8)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure( .unknown))
                return
            }
            guard let data else {
                completion(.failure( .noData))
                return
            }
            
            guard let heroes = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion(.failure( .decodingFailed))
                return
            }
            completion(.success(heroes))
        }
        
        task.resume()
    }
   
    func getTransformations(for hero: Hero,
                            completion: @escaping (
                                Result<[Transformation],
                                NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/transformations"
        
        guard let url = components.url else {
            return
        }
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94")]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = urlComponents.query?.data(using: .utf8)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard error == nil else {
                completion(.failure(.unknown))
                return
            }
            guard let data else {
                completion(.failure( .noData))
                return
            }
            
            guard let transformation = try? JSONDecoder().decode([Transformation].self, from: data) else {
                completion(.failure( .decodingFailed))
                return
            }
            completion(.success(transformation))
        }
        task.resume()
    }
     
    func getTransformations2(for hero: Hero,
                             token: String,
                            completion: @escaping (
                                Result<[Transformation],
                                NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/transformations"
        
        guard let url = components.url else {
            completion(.failure(.malformedUrl))
            return
        }
        
        let body = GetTransformationBody(id: hero.id)
        
        guard let encodeBody = try? JSONEncoder().encode(body) else {
            completion(.failure(.encodingfailed))
            return
        }
        
       var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = encodeBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error != nil else {
                completion(.failure(.unknown))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            guard let transformations = try? JSONDecoder().decode([Transformation].self, from: data) else {
                completion(.failure(.decodingFailed))
                return
            }
            
            completion(.success(transformations))
        }
        task.resume()
    }
}
