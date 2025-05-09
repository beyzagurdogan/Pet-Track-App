import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    @State private var pets: [Pet] = []

    var body: some View {
        VStack(spacing: 30) {
            Spacer(minLength: 50)

            Text("🐾 Pet Tracker 🐾")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "#F8F8F2"))
                .padding(.top)

            if pets.isEmpty {
                VStack(spacing: 20) {
                    Text("No pets added yet.")
                        .foregroundColor(.white)
                        .font(.title3)

                    NavigationLink(destination: PetInputFormView(path: $path)) {
                        Text("Add Your First Pet")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 50)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(pets) { pet in
                            VStack(spacing: 5) {
                                Image(pet.type.lowercased())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)

                                Text(pet.name)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)

                                Text("Breed: \(pet.breed)")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)

                                Text("Weight: \(String(format: "%.2f", pet.weight)) kg")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(16)
                            .frame(width: 220)
                            .onLongPressGesture {
                                deletePet(pet: pet)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                NavigationLink(destination: PetInputFormView(path: $path)) {
                    Text("Add Another Pet")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .padding(.top)
            }

            Spacer()
        }
        .padding()
        .background(Color(hex: "#1E1E2E"))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            pets = PetStorage.shared.load()
        }
        .navigationBarBackButtonHidden(true) // 🔒 Geri butonunu gizler
    }

    private func deletePet(pet: Pet) {
        if let index = pets.firstIndex(where: { $0.id == pet.id }) {
            pets.remove(at: index)
            PetStorage.shared.delete(pet: pet)
        }
    }
}

