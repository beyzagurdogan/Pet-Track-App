import SwiftUI

struct PetInfoView: View {
    // UserDefaults'tan alınan veriler
    @State private var petName: String = ""
    @State private var petAge: String = ""
    @State private var petWeight: String = ""

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Title
            Text("Pet Information")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "#F8F8F2")) // Beyaz metin
                .padding(.bottom, 20)

            // Eğer veriler yoksa uyarı mesajı
            if petName.isEmpty || petAge.isEmpty || petWeight.isEmpty {
                Text("No pet information found. Please enter the pet info first.")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .padding()
            } else {
                VStack(spacing: 15) {
                    // Pet Name
                    HStack {
                        Text("🐶 Name:")
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "#8BE9FD")) // Canlı Mavi
                        Text(petName)
                            .foregroundColor(.white)
                    }

                    // Pet Age
                    HStack {
                        Text("📅 Age:")
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "#50FA7B")) // Yumuşak Yeşil
                        Text(petAge)
                            .foregroundColor(.white)
                    }

                    // Pet Weight
                    HStack {
                        Text("🐾 Weight:")
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "#FFB86C")) // Sıcak Sarı
                        Text(petWeight)
                            .foregroundColor(.white)
                    }
                    
                    

                    // Pet Weight
                    HStack {
                        Text("❤️‍🩹 Health:")
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "#FFB86C"))
                        Text(String(predict(age: Int64(petAge)!, weight: Double(petWeight)!)))
                            .foregroundColor(.white)
                    }
                }
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#282A36")) // Daha koyu gri
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)
            }

            Spacer()
        }
        .onAppear {
            // Ekran göründüğünde verileri UserDefaults'tan al
            loadPetInfo()
        }
        .padding()
        .background(Color(hex: "#1E1E2E")) // Modern Koyu Gri
        .edgesIgnoringSafeArea(.all)
    }
    
    // UserDefaults'tan veriyi almak için fonksiyon
    func loadPetInfo() {
        petName = UserDefaults.standard.string(forKey: "petName") ?? ""
        petAge = UserDefaults.standard.string(forKey: "petAge") ?? ""
        petWeight = UserDefaults.standard.string(forKey: "petWeight") ?? ""
    }
    
    func predict(age: Int64, weight: Double) -> Double {
        let petHealthPredicter = try? PetHealthGuessr(configuration: .init())
        let output = try? petHealthPredicter?.prediction(age: age, weight: weight)
        return output?.health_score ?? 0
    }
}

struct PetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PetInfoView()
    }
}
