import SwiftUI

struct SendView: View {
    @State private var to = ""
    @State private var amount = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Form {
            TextField("Recipient", text: $to)
            TextField("Amount", text: $amount).keyboardType(.decimalPad)
            Button("Send") { dismiss() }
        }.navigationTitle("Send")
    }
}
