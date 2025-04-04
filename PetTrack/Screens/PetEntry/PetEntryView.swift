import SwiftUI

struct PetEntryView: View {
    @State private var petName: String = ""
    @State private var petAge: String = ""
    @State private var petWeight: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Enter Pet Info")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white) // Yazıyı beyaz yaptık
                .padding(.bottom, 20)

            // Text Fields
            CustomTextField(placeholder: "Pet Name", text: $petName)
            CustomTextField(placeholder: "Pet Age", text: $petAge)
            CustomNumberField(placeholder: "Pet Weight", text: $petWeight)

            // Save Button
            Button(action: savePetInfo) {
                Text("Save Info")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black) // Kontrast için siyah yazı
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#FFDE59")) // Sarı buton
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .background(Color(hex: "#282A36")) // Daha modern koyu arka plan
        .edgesIgnoringSafeArea(.all)
    }

    func savePetInfo() {
        UserDefaults.standard.set(petName, forKey: "petName")
        UserDefaults.standard.set(petAge, forKey: "petAge")
        UserDefaults.standard.set(petWeight, forKey: "petWeight")
    }
}
