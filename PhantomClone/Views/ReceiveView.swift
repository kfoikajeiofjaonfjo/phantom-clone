import SwiftUI

struct ReceiveView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Your address").font(.headline)
            Text("7xKX...9QmT").font(.system(.title3, design: .monospaced))
        }.padding()
    }
}
