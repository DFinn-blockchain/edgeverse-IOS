import Foundation

final class TransakProvider: PurchaseProviderProtocol {
    // TODO: Put pub token
    #if F_RELEASE
        static let pubToken = ""
        static let baseUrlString = "https://global.transak.com"
    #else
        static let pubToken = ""
        static let baseUrlString = "https://staging-global.transak.com"
    #endif

    private var callbackUrl: URL?

    func with(callbackUrl: URL) -> Self {
        self.callbackUrl = callbackUrl
        return self
    }

    func buildPurchaseActions(for chainAsset: ChainAsset, accountId: AccountId) -> [PurchaseAction] {
        guard
            let transak = chainAsset.asset.buyProviders?.transak,
            let address = try? accountId.toAddress(using: chainAsset.chain.chainFormat) else {
            return []
        }

        let token = chainAsset.asset.symbol
        let network = transak.network?.stringValue ?? chainAsset.chain.name.lowercased()

        guard let url = buildURLForToken(token, network: network, address: address) else {
            return []
        }

        let action = PurchaseAction(title: "Transak", url: url, icon: R.image.iconTransak()!)

        return [action]
    }

    private func buildURLForToken(_ token: String, network: String, address: String) -> URL? {
        var components = URLComponents(string: Self.baseUrlString)

        var queryItems = [
            URLQueryItem(name: "apiKey", value: Self.pubToken),
            URLQueryItem(name: "network", value: network),
            URLQueryItem(name: "cryptoCurrencyCode", value: token),
            URLQueryItem(name: "walletAddress", value: address),
            URLQueryItem(name: "disableWalletAddressForm", value: "true")
        ]

        if let callbackUrl = callbackUrl?.absoluteString {
            queryItems.append(URLQueryItem(name: "redirectURL", value: callbackUrl))
        }

        components?.queryItems = queryItems

        return components?.url
    }
}
