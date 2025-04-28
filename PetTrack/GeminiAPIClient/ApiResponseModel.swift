//
//  ApiResponseModel.swift
//  PetTrack
//
//  Created by Beyza Gurdogan on 28.04.2025.
//

struct GeminiResponseBody: Codable {
    let candidates: [Candidate]
}

struct Candidate: Codable {
    let content: Content
}
