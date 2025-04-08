import SwiftUI

struct HomeView: View {
    @State private var pets: [Pet] = []

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
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
                        
                        NavigationLink(destination: PetInputFormView()) {
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
                                    Image(pet.type.lowercased()) // örnek olarak "dog" ya da "cat" image asset varsa
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

                                    Text("Weight: \(pet.weight) kg")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(16)
                                .frame(width: 220)
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Yeni Evcil Hayvan Ekleme Butonu
                    NavigationLink(destination: PetInputFormView()) {
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
            .navigationBarHidden(true)
        }
    }
}

