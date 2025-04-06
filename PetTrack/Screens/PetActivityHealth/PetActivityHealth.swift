import SwiftUI

struct PetActivityHealthView: View {
    @Binding var activityLevel: String
    @Binding var dailyExerciseMinutes: String
    @Binding var vaccinated: Bool

    // 3. sayfa için gerekli veriler (local state)
    @State private var feedingType = ""
    @State private var mealsPerDay = ""
    @State private var favoriteFood = ""
    @State private var toiletHabit = ""
    @State private var sleepPattern = ""
    @State private var additionalNotes = ""

    var body: some View {
        VStack(spacing: 28) {
            // Başlık
            Text("Activity & Health 🏃‍♂️")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Aktivite Düzeyi
            VStack(alignment: .leading, spacing: 8) {
                Text("Activity Level")
                    .font(.headline)
                    .foregroundColor(.gray)

                HStack(spacing: 16) {
                    ForEach(["Low", "Medium", "High"], id: \.self) { level in
                        Button(action: {
                            activityLevel = level
                        }) {
                            Text(level)
                                .fontWeight(.medium)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(activityLevel == level ? Color.blue.opacity(0.2) : Color(.systemGray6))
                                .foregroundColor(activityLevel == level ? .blue : .primary)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(activityLevel == level ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                    }
                }
            }

            // Egzersiz Süresi
            StyledTextField(
                title: "Daily Exercise (minutes)",
                placeholder: "e.g. 30",
                text: $dailyExerciseMinutes,
                keyboardType: .numberPad
            )

            // Aşı durumu
            VStack(alignment: .leading, spacing: 8) {
                Toggle(isOn: $vaccinated) {
                    Text("Vaccinated")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            }

            Spacer()

            // Devam butonu
            NavigationLink(
                destination: PetNutritionHabitsView(
                    feedingType: $feedingType,
                    mealsPerDay: $mealsPerDay,
                    favoriteFood: $favoriteFood,
                    toiletHabit: $toiletHabit,
                    sleepPattern: $sleepPattern,
                    additionalNotes: $additionalNotes
                )
            ) {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(colors: [Color.teal, Color.blue], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(14)
                    .shadow(color: .blue.opacity(0.3), radius: 6, x: 0, y: 4)
            }
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

