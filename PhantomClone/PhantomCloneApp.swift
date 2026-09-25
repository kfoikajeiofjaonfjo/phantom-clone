import SwiftUI

@main
struct PhantomCloneApp: App {
    @State private var store = WalletStore()
    var body: some Scene {
        WindowGroup {
            RootTabView().environment(store)
        }
    }
}
