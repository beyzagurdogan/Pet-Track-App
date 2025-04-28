import SwiftUI

struct PetSummaryView: View {
    @Binding var path: NavigationPath
    
    @Binding var activityLevel: String
    @Binding var dailyExerciseMinutes: String
    @Binding var vaccinated: Bool
    @Binding var feedingType: String
    @Binding var mealsPerDay: String
    @Binding var favoriteFood: String
    @Binding var toiletHabit: String
    @Binding var sleepPattern: String
    @Binding var additionalNotes: String
    @Binding var weight: String
    
    @State private var name = ""
    @State private var breed = ""
    @State private var calculatedHealthScore: Double = 50.0
    @State private var aiSuggestion: String = ""  // AI önerisini buraya alacağız

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Pet Health Summary 🩺")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Sağlık Durumu Grafiği
                VStack(spacing: 12) {
                    Text("Health Score")
                        .font(.headline)
                        .foregroundColor(.gray)

                    ZStack {
                        Circle()
                            .stroke(lineWidth: 20)
                            .opacity(0.2)
                            .foregroundColor(.blue)

                        Circle()
                            .trim(from: 0.0, to: CGFloat(calculatedHealthScore / 100))
                            .stroke(
                                AngularGradient(gradient: Gradient(colors: [.green, .yellow, .red]), center: .center),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .animation(.easeOut(duration: 1.0), value: calculatedHealthScore)

                        Text("\(Int(calculatedHealthScore)) / 100")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .frame(width: 180, height: 180)
                }

                // Yapay Zekâ Önerisi
                VStack(alignment: .leading, spacing: 12) {
                    Text("AI Suggestions 💡")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Text(LocalizedStringKey(aiSuggestion))  // Burada AI'den gelen öneriyi gösteriyoruz
                        .font(.body)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }

                // ✅ Finish Butonu
                Button(action: {
                    path.removeLast(path.count)
                    path.append("Home")
                }) {
                    Text("Finish")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(colors: [Color.teal, Color.blue], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(16)
                        .shadow(color: .blue.opacity(0.3), radius: 6, x: 0, y: 4)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
        
            // Gemini API'den önerileri alıyoruz
            let petInfo: [String: Any] = [
                "type": "Dog",
                "weight": weight,
                "activityLevel": activityLevel,
                "vaccinated": vaccinated,
                "dietType": feedingType
            ]

            let geminiClient = GeminiAPIClient()
            geminiClient.fetchSuggestion(petInfo: petInfo) { result in
                switch result {
                case .success(let suggestion):
                    DispatchQueue.main.async {
                        // Burada AI önerilerini kullanıyoruz
                        aiSuggestion = suggestion
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        aiSuggestion = "Error fetching suggestions: \(error.localizedDescription)"
                    }
                }
            }
            
            if let predictor = HealthPredictor() {
                print("Model yüklendi.")
                if let predictedScore = predictor.predictHealthScore(
                    type: "Dog",
                    weight: Double(weight) ?? 5.0,
                    activityLevel: activityLevel,
                    vaccinated: vaccinated,
                    dietType: feedingType
                ) {
                    print("Tahmin yapıldı: \(predictedScore)")
                    calculatedHealthScore = predictedScore
                } else {
                    print("Tahmin yapılamadı, varsayılan skor kullanılacak.")
                    calculatedHealthScore = 50.0
                }
            } else {
                print("Model yüklenemedi, varsayılan skor kullanılacak.")
                calculatedHealthScore = 50.0
            }

          
        }
    }
    
}

