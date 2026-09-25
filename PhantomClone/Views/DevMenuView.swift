import SwiftUI

struct DevMenuView: View {
    @Environment(WalletStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var mint = ""
    @State private var symbol = ""
    @State private var name = ""
    @State private var amount = ""
    @State private var decimals = "9"

    var body: some View {
        NavigationStack {
            Form {
                Section("Add / top up") {
                    TextField("Mint", text: $mint)
                    TextField("Symbol", text: $symbol)
                    TextField("Name", text: $name)
                    TextField("Amount", text: $amount).keyboardType(.decimalPad)
                    TextField("Decimals", text: $decimals).keyboardType(.numberPad)
                    Button("Add") {
                        guard let a = Double(amount), let d = Int(decimals) else { return }
                        store.add(mint: mint, symbol: symbol, name: name, amount: a, decimals: d)
                        Task { await store.refresh() }
                        dismiss()
                    }.disabled(mint.isEmpty || amount.isEmpty)
                }
                Section("Wallet") {
                    Button("Reset to seed", role: .destructive) { store.reset() }
                    Button("Clear all", role: .destructive) { store.clear() }
                }
            }
            .navigationTitle("Dev Menu")
            .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Close") { dismiss() } } }
        }
    }
}
