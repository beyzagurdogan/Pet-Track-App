import SwiftUI

struct PetSummaryView: View {
    let activityLevel: String
    let dailyExerciseMinutes: String
    let vaccinated: Bool
    let feedingType: String
    let mealsPerDay: String
    let favoriteFood: String
    let toiletHabit: String
    let sleepPattern: String
    let additionalNotes: String

    var healthScore: Double {
        var score = 50.0
        if vaccinated { score += 20 }
        if let exercise = Double(dailyExerciseMinutes), exercise >= 30 { score += 15 }
        if feedingType != "" { score += 10 }
        if sleepPattern != "" { score += 5 }
        return min(score, 100)
    }

    var suggestion: String {
        if !vaccinated {
            return "Pet is not vaccinated. Please consult a vet to ensure full protection."
        } else if let exercise = Double(dailyExerciseMinutes), exercise < 20 {
            return "Try to increase daily exercise to improve health."
        } else {
            return "Great job! Your pet seems healthy overall. Keep up the good care."
        }
    }

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
                            .trim(from: 0.0, to: CGFloat(healthScore / 100))
                            .stroke(
                                AngularGradient(gradient: Gradient(colors: [.green, .yellow, .red]), center: .center),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .animation(.easeOut(duration: 1.0), value: healthScore)

                        Text("\(Int(healthScore)) / 100")
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

                    Text(suggestion)
                        .font(.body)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }

                // Formu Tamamla Butonu
                Button(action: {
                    // Geri anasayfaya veya başka bir aksiyon
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
        .navigationBarHidden(true)
    }
}

