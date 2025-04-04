import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Spacer()
                
                Text("🐾 Pet Tracker 🐾")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#F8F8F2")) // Beyaz metin
                    .padding(.bottom, 20)

                // Enter Pet Info Button
                NavigationLink(destination: PetEntryView()) {
                    Text("Enter Pet Info")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#8BE9FD")) // Canlı Mavi
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                }

                // View Pet Info Button (Bu buton ile PetInfoView ekranına geçiş yapacağız)
                NavigationLink(destination: PetInfoView()) {
                    Text("View Pet Info")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#50FA7B")) // Yumuşak Yeşil
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .background(Color(hex: "#1E1E2E")) // Modern Koyu Gri
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true) // Başlık bar'ını gizliyoruz
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

