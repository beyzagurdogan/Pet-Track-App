import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath() // 🔧 Bunu ekledik
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path) // Ana ekranı başlangıç olarak ayarla
        }
        .navigationViewStyle(StackNavigationViewStyle()) // iPad uyumluluğu için
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

