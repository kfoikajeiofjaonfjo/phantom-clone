import SwiftUI

struct TokenDetailView: View {
    let token: Token
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 20) {
                Capsule().fill(.white.opacity(0.3)).frame(width: 40, height: 5).padding(.top, 8)
                Text(token.symbol).font(.largeTitle.bold()).foregroundStyle(.white)
                Text("$\(token.valueUSD, specifier: "%.2f")").font(.title).foregroundStyle(.white)
                Text("\(token.amount, specifier: "%.6f") \(token.symbol)").foregroundStyle(.white.opacity(0.6))
                Spacer()
            }
            .padding()
        }
    }
}
