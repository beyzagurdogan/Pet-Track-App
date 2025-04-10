import SwiftUI

struct AppNavigationRootView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: String.self) { value in
                    switch value {
                    case "Home":
                        HomeView(path: $path)
                            .navigationBarBackButtonHidden(true) // Ana sayfada geri butonu olmasın
                    default:
                        EmptyView()
                    }
                }
        }
    }
}

