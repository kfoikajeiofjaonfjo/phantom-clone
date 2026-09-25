import Foundation

actor PriceService {
    static let shared = PriceService()
    private let jup = "https://api.jup.ag/price/v2?ids="

    func prices(for mints: [String]) async throws -> [String: Double] {
        guard !mints.isEmpty else { return [:] }
        guard let url = URL(string: jup + mints.joined(separator: ",")) else { return [:] }
        let (data, _) = try await URLSession.shared.data(from: url)
        struct Resp: Decodable {
            struct Entry: Decodable { let price: String? }
            let data: [String: Entry]
        }
        let r = try JSONDecoder().decode(Resp.self, from: data)
        var out: [String: Double] = [:]
        for (mint, e) in r.data {
            if let p = e.price, let d = Double(p) { out[mint] = d }
        }
        return out
    }
}
