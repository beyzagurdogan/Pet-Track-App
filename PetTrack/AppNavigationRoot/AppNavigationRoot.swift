import SwiftUI

struct AppNavigationRootView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path) // ilk form ekranı
        }
    }
}
