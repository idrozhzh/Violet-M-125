//
//  NetworkManager.swift
//  Violet M-125
//
//  Created by Иван Дрожжин on 12.08.2022.
//

import Foundation
enum WorkingMode: String {
    case encryption = "encrypt"
    case decryption = "decrypt"
}
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let link = "https://classify-web.herokuapp.com/api/"
    
    private init() {}
    
    func postMessage(with data: CryptoMessage, to url: URL, completion: @escaping(Result<Any, NetworkError>) -> Void) {
        let cryptoData = try? JSONSerialization.data(withJSONObject: data)
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
    
    func doUrl(with workingMode: WorkingMode) -> URL? {
        guard let url = URL(string: "\(link)\(workingMode.rawValue)") else { return nil }
        return url
    }
}
