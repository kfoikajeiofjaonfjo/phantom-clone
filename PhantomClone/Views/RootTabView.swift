import SwiftUI

struct RootTabView: View {
    @Environment(WalletStore.self) private var store
    @State private var tab = 0

    var body: some View {
        TabView(selection: $tab) {
            WalletView().tabItem { Label("Wallet", systemImage: "wallet.pass") }.tag(0)
            PlaceholderView(title: "NFTs").tabItem { Label("NFTs", systemImage: "square.grid.2x2") }.tag(1)
            PlaceholderView(title: "Swap").tabItem { Label("Swap", systemImage: "arrow.left.arrow.right") }.tag(2)
            PlaceholderView(title: "Browser").tabItem { Label("Browser", systemImage: "globe") }.tag(3)
        }
        .tint(Color(red: 0.67, green: 0.62, blue: 0.95))
        .task { await store.refresh() }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            Task { await store.refresh() }
        }
    }
}

struct PlaceholderView: View {
    let title: String
    var body: some View {
        VStack { Text(title).font(.title2).foregroundStyle(.secondary) }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
    }
}
