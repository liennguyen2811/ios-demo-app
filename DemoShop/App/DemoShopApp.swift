import SwiftUI

@main
struct DemoShopApp: App {
    @StateObject private var auth = AuthViewModel()
    @StateObject private var cart = CartStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(auth)
                .environmentObject(cart)
        }
    }
}
