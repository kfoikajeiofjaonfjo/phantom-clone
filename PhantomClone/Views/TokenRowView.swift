import SwiftUI

struct TokenRowView: View {
    let token: Token
    var body: some View {
        HStack(spacing: 12) {
            Circle().fill(Color(red: 0.67, green: 0.62, blue: 0.95))
                .frame(width: 40, height: 40)
                .overlay(Text(String(token.symbol.prefix(1)))
                    .foregroundStyle(.white).font(.headline))
            VStack(alignment: .leading, spacing: 2) {
                Text(token.symbol).foregroundStyle(.white).font(.headline)
                Text("\(token.amount, specifier: "%.4f")").foregroundStyle(.white.opacity(0.6)).font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("$\(token.valueUSD, specifier: "%.2f")").foregroundStyle(.white).font(.headline)
                Text("$\(token.priceUSD, specifier: "%.2f")").foregroundStyle(.white.opacity(0.6)).font(.subheadline)
            }
        }
        .padding(12)
        .background(Color.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
