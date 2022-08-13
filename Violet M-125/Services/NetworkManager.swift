//
//  NetworkManager.swift
//  Violet M-125
//
//  Created by Иван Дрожжин on 12.08.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case postEncrypt = "https://classify-web.herokuapp.com/api/encrypt"
    case postDecrypt = "https://classify-web.herokuapp.com/api/decrypt"
    case getKey = "https://classify-web.herokuapp.com/api/keygen?length=10&symbols=0"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let link = "https://classify-web.herokuapp.com/api/"
    
    private init() {}
    
    func postMessage(with data: CryptoMessage, to url: String, completion: @escaping(Result<Any, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        guard let cryptoData = try? JSONEncoder().encode(data) else {
            completion(.failure(.noData))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = cryptoData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchGeneratedKey(completion: @escaping(Result<Pressmark, NetworkError>) -> Void) {
        guard let url = URL(string: Link.getKey.rawValue) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let key = try JSONDecoder().decode(Pressmark.self, from: data)
                completion(.success(key))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }
}
