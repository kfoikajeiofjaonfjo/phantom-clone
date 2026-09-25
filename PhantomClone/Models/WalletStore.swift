import Foundation
import Observation

@MainActor
@Observable
final class WalletStore {
    var tokens: [Token] = [] { didSet { persist() } }
    var lastRefresh: Date?

    private let key = "wallet.tokens"

    init() {
        if let d = UserDefaults.standard.data(forKey: key),
           let t = try? JSONDecoder().decode([Token].self, from: d) {
            tokens = t
        } else {
            tokens = Seed.tokens
        }
    }

    private func persist() {
        if let d = try? JSONEncoder().encode(tokens) {
            UserDefaults.standard.set(d, forKey: key)
        }
    }

    func refresh() async {
        do {
            let mints = tokens.map(\.mint)
            let p = try await PriceService.shared.prices(for: mints)
            for i in tokens.indices {
                if let v = p[tokens[i].mint] { tokens[i].priceUSD = v }
            }
            lastRefresh = Date()
        } catch { }
    }

    func add(mint: String, symbol: String, name: String, amount: Double, decimals: Int) {
        if let i = tokens.firstIndex(where: { $0.mint == mint }) {
            tokens[i].amount += amount
        } else {
            tokens.append(.init(mint: mint, symbol: symbol, name: name,
                                amount: amount, decimals: decimals))
        }
    }

    func reset() { tokens = Seed.tokens }
    func clear() { tokens = [] }

    var totalUSD: Double { tokens.reduce(0) { $0 + $1.valueUSD } }
}
