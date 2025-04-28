import SwiftUI

struct PetNutritionHabitsView: View {
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

    let feedingOptions = ["Dry Food", "Raw", "Mixed", ]
    let toiletOptions = ["Litter Box", "Outdoor", "Pee Pad", "Mixed"]

    var body: some View {
        VStack(spacing: 48) {
            // Başlık
            Text("Nutrition & Habits 🍽")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Beslenme Türü
            VStack(alignment: .leading, spacing: 8) {
                Text("Feeding Type")
                    .font(.headline)
                    .foregroundColor(.gray)

                Picker("Feeding Type", selection: $feedingType) {
                    ForEach(feedingOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 12)
            }

            // Günlük Öğün Sayısı
            VStack(alignment: .leading, spacing: 8) {
                Text("Meals per Day")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("e.g. 2", text: $mealsPerDay)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.bottom, 12)
            }

        
            // Tuvalet Alışkanlığı
            VStack(alignment: .leading, spacing: 8) {
                Text("Toilet Habit")
                    .font(.headline)
                    .foregroundColor(.gray)

                Picker("Toilet Habit", selection: $toiletHabit) {
                    ForEach(toiletOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 12)
            }

        

            // Ekstra Notlar
            VStack(alignment: .leading, spacing: 8) {
                Text("Additional Notes")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Any special notes?", text: $additionalNotes)
                    .keyboardType(.default)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.bottom, 12)
            }

            Spacer()

            // Devam Butonu
            NavigationLink(
                destination: PetSummaryView(
                    path: $path,
                    activityLevel: $activityLevel,  // Binding olmadan doğrudan geçiş
                    dailyExerciseMinutes: $dailyExerciseMinutes, // Binding olmadan doğrudan geçiş
                    vaccinated: $vaccinated, // Binding olmadan doğrudan geçiş
                    feedingType: $feedingType, // Binding olmadan doğrudan geçiş
                    mealsPerDay: $mealsPerDay,
                    favoriteFood: $favoriteFood, // Binding olmadan doğrudan geçiş
                    toiletHabit: $toiletHabit, // Binding olmadan doğrudan geçiş
                    sleepPattern: $sleepPattern, // Binding olmadan doğrudan geçiş
                    additionalNotes: $additionalNotes, // Binding olmadan doğrudan geçiş
                    weight: $weight
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
    }
}

