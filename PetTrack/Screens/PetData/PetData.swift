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

    // Yeni pet eklemek
    func save(_ pet: Pet) {
        var currentPets = load()
        currentPets.append(pet)
        if let data = try? JSONEncoder().encode(currentPets) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    // Petleri yüklemek
    func load() -> [Pet] {
        if let data = UserDefaults.standard.data(forKey: key),
           let pets = try? JSONDecoder().decode([Pet].self, from: data) {
            return pets
        }
        return []
    }

    // Pet silme işlemi
    func delete(pet: Pet) {
        var currentPets = load() // Önce tüm petleri yükle
        if let index = currentPets.firstIndex(where: { $0.id == pet.id }) {
            currentPets.remove(at: index) // Pet'i diziden sil
            if let data = try? JSONEncoder().encode(currentPets) {
                UserDefaults.standard.set(data, forKey: key) // Güncellenmiş listeyi kaydet
            }
        }
    }
}

