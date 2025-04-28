//
//  ApiRequestModel.swift
//  PetTrack
//
//  Created by Beyza Gurdogan on 28.04.2025.
//

import Foundation

struct GeminiRequestBody: Codable {
    let contents: [Content]
}

struct Content: Codable {
    let parts: [Part]
}

struct Part: Codable {
    let text: String
}
