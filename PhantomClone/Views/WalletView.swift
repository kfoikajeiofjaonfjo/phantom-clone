import SwiftUI

struct WalletView: View {
    @Environment(WalletStore.self) private var store
    @State private var showDev = false
    @State private var selected: Token?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        header
                        tokenList
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selected) { TokenDetailView(token: $0) }
            .sheet(isPresented: $showDev) { DevMenuView() }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "wallet.pass.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .onLongPressGesture(minimumDuration: 5) { showDev = true }
                Spacer()
                Button { Task { await store.refresh() } } label: {
                    Image(systemName: "arrow.clockwise").foregroundStyle(.white)
                }
            }
            Text("$\(store.totalUSD, specifier: "%.2f")")
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
            Text("Total balance")
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.6))
            HStack(spacing: 12) {
                action("arrow.up", "Send")
                action("arrow.down", "Receive")
                action("arrow.left.arrow.right", "Swap")
            }
            .padding(.top, 8)
        }
    }

    private func action(_ icon: String, _ label: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(Color.white.opacity(0.12))
                .clipShape(Circle())
            Text(label).font(.caption).foregroundStyle(.white.opacity(0.8))
        }
    }

    private var tokenList: some View {
        VStack(spacing: 4) {
            ForEach(store.tokens) { t in
                Button { selected = t } label: { TokenRowView(token: t) }
                    .buttonStyle(.plain)
            }
        }
    }
}
