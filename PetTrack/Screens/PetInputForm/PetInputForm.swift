import SwiftUI

struct PetInputFormView: View {
    @State private var type = "Dog"
    @State private var name = ""
    @State private var breed = ""
    @State private var weight = ""

    let dogBreeds = ["Golden Retriever", "Labrador", "Poodle", "Bulldog", "Beagle"]
    let catBreeds = ["Siamese", "Persian", "Sphynx", "Maine Coon", "Bengal"]

    var breedOptions: [String] {
        type == "Dog" ? dogBreeds : catBreeds
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 28) {
                
                // Başlık
                Text("Tell us about your pet 🐾")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Pet tipi seçimi
                HStack(spacing: 20) {
                    PetTypeCard(image: "cat", title: "Cat", isSelected: type == "Cat", color: .pink) {
                        type = "Cat"
                        breed = ""
                    }
                    PetTypeCard(image: "dog", title: "Dog", isSelected: type == "Dog", color: .blue) {
                        type = "Dog"
                        breed = ""
                    }
                }

                // Pet İsmi
                StyledTextField(title: "Pet Name", placeholder: "e.g. Bella", text: $name)

                // Irk Seçimi
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(type) Breed")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Menu {
                        ForEach(breedOptions, id: \.self) { breedOption in
                            Button(action: {
                                breed = breedOption
                            }) {
                                Text(breedOption)
                            }
                        }
                    } label: {
                        HStack {
                            Text(breed.isEmpty ? "Select Breed" : breed)
                                .foregroundColor(breed.isEmpty ? .gray : .primary)
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

                // Kilo Girişi
                StyledTextField(title: "Weight (kg)", placeholder: "e.g. 5.4", text: $weight, keyboardType: .decimalPad)

                Spacer()

                // Devam Butonu
                NavigationLink(
                    destination: PetActivityHealthView(activityLevel: .constant("Medium"), dailyExerciseMinutes: .constant("30"), vaccinated: .constant(true)), // 2. sayfa
                    label: {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(colors: [Color.teal, Color.blue], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(14)
                            .shadow(color: .blue.opacity(0.3), radius: 6, x: 0, y: 4)
                    }
                )
                .padding(.bottom)
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}

// Görsel kartlar
struct PetTypeCard: View {
    let image: String
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? color : .primary)
            }
            .padding()
            .frame(width: 130, height: 160)
            .background(isSelected ? color.opacity(0.15) : Color(.systemGray6))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? color : .clear, lineWidth: 2)
            )
            .shadow(color: isSelected ? color.opacity(0.3) : .clear, radius: 4, x: 0, y: 2)
        }
    }
}

// Giriş alanları için yeniden kullanılabilir stil
struct StyledTextField: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

