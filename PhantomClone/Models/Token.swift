import Foundation

struct Token: Identifiable, Codable, Hashable {
    var id: String { mint }
    let mint: String
    var symbol: String
    var name: String
    var amount: Double
    var decimals: Int
    var priceUSD: Double = 0

    var valueUSD: Double { amount * priceUSD }
}

enum Seed {
    static let tokens: [Token] = [
        .init(mint: "So11111111111111111111111111111111111111112",
              symbol: "SOL", name: "Solana", amount: 12.5, decimals: 9),
        .init(mint: "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v",
              symbol: "USDC", name: "USD Coin", amount: 250, decimals: 6),
        .init(mint: "JUPyiwrYJFskUPiHa7hkeR8VUtAeFoSYbKedZNsDvCN",
              symbol: "JUP", name: "Jupiter", amount: 1.2, decimals: 6),
        .init(mint: "mSoLzYCxHdYgdzU16g5QSh3i5K3z3KZK7ytfqcJm7So",
              symbol: "mSOL", name: "Marinade staked SOL", amount: 0.05, decimals: 9)
    ]
}
