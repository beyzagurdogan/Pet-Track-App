import Foundation
import SwiftUI


struct Pet: Codable, Identifiable {
    var id = UUID()
    var type: String
    var name: String
    var breed: String
    var weight: String
}


class PetStorage {
    static let shared = PetStorage()
    private let key = "savedPets"

    func save(_ pet: Pet) {
        var currentPets = load()
        currentPets.append(pet)
        if let data = try? JSONEncoder().encode(currentPets) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [Pet] {
        if let data = UserDefaults.standard.data(forKey: key),
           let pets = try? JSONDecoder().decode([Pet].self, from: data) {
            return pets
        }
        return []
    }
}
