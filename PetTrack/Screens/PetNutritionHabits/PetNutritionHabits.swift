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

    let feedingOptions = ["Dry Food", "Wet Food", "Mixed", "Home Cooked"]
    let toiletOptions = ["Litter Box", "Outdoor", "Pee Pad", "Mixed"]

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                // Başlık
                Text("Nutrition & Habits 🍽️")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)

                // Beslenme Şekli
                VStack(alignment: .leading, spacing: 8) {
                    Text("Feeding Type")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Menu {
                        ForEach(feedingOptions, id: \.self) { option in
                            Button {
                                feedingType = option
                            } label: {
                                Text(option)
                            }
                        }
                    } label: {
                        HStack {
                            Text(feedingType.isEmpty ? "Select Feeding Type" : feedingType)
                                .foregroundColor(feedingType.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }

                // Öğün Sayısı
                StyledTextField(title: "Meals Per Day", placeholder: "e.g. 2", text: $mealsPerDay, keyboardType: .numberPad)

                // Favori Mama
                StyledTextField(title: "Favorite Food (Optional)", placeholder: "e.g. Royal Canin", text: $favoriteFood)

           

              
                // Notlar
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notes (Optional)")
                        .font(.headline)
                        .foregroundColor(.gray)
                    TextEditor(text: $additionalNotes)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }

                // Devam Butonu → Özet Sayfasına Git
                NavigationLink(
                    destination: PetSummaryView(
                        path: $path,
                        activityLevel: activityLevel,
                        dailyExerciseMinutes: dailyExerciseMinutes,
                        vaccinated: vaccinated,
                        feedingType: feedingType,
                        mealsPerDay: mealsPerDay,
                        favoriteFood: favoriteFood,
                        toiletHabit: toiletHabit,
                        sleepPattern: sleepPattern,
                        additionalNotes: additionalNotes
                    )
                ) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(colors: [Color.teal, Color.blue], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(18)
                        .shadow(color: .blue.opacity(0.3), radius: 6, x: 0, y: 4)
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        
    }
}

