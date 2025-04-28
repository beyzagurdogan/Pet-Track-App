import CoreML

class HealthPredictor {
    private let model: HealthData

    init?() {
        guard let model = try? HealthData(configuration: MLModelConfiguration()) else {
            return nil
        }
        self.model = model
    }

    func predictHealthScore(type: String, weight: Double, activityLevel: String, vaccinated: Bool, dietType: String) -> Double? {
        // Veri güvenliği
        let safeType = type.isEmpty ? "Dog" : type
        let safeWeight = weight > 0 ? weight : 5.0
        let safeActivityLevel = activityLevel.isEmpty ? "Low" : activityLevel
        let safeVaccinated = vaccinated ? "Yes" : "No"
        let safeDietType = normalizeDietType(dietType)

        do {
            let prediction = try model.prediction(
                type: safeType,
                weight: safeWeight,
                activity_level: safeActivityLevel,
                vaccinated: safeVaccinated,
                diet_type: safeDietType
            )
            return Double(prediction.health_score)
        } catch {
            print("Prediction failed: \(error)")
            return nil
        }
    }

    // Diyet tipi düzeltici
    private func normalizeDietType(_ dietType: String) -> String {
        let lowercased = dietType.lowercased()
        
        if lowercased.contains("dry") {
            return "Dry"
        } else if lowercased.contains("mixed") {
            return "Mixed"
        } else if lowercased.contains("raw") {
            return "Raw"
        } else {
            return "Dry" // Güvenli varsayılan
        }
    }
}

