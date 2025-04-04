import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView() // Ana ekranı başlangıç olarak ayarla
        }
        .navigationViewStyle(StackNavigationViewStyle()) // iPad uyumluluğu için
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

