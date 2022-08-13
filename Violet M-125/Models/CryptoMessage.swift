//
//  CryptoMessage.swift
//  Violet M-125
//
//  Created by Иван Дрожжин on 12.08.2022.
//

struct CryptoMessage: Codable {
    var data: String
    var key: String
}

struct Pressmark: Codable {
    var key: String
}

enum WorkingMode: String {
    case encryption = "encrypt"
    case decryption = "decrypt"
}
