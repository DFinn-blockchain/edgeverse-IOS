import Foundation
import os

protocol ApplicationConfigProtocol {
    var termsURL: URL { get }
    var privacyPolicyURL: URL { get }
    var websiteURL: URL { get }
    var version: String { get }
    var opensourceURL: URL { get }
    var appName: String { get }
    var logoURL: URL { get }
    var purchaseAppName: String { get }
    var moonPayApiKey: String { get }
    var purchaseRedirect: URL { get }
    var phishingListURL: URL { get }
    var phishingDAppsURL: URL { get }
    var chainListURL: URL { get }
    var dAppsListURL: URL { get }
    var commonTypesURL: URL { get }
    var learnPayoutURL: URL { get }
    var learnControllerAccountURL: URL { get }
    var learnRecommendedValidatorsURL: URL { get }
    var canDebugDApp: Bool { get }
    var fileCachePath: String { get }
}

final class ApplicationConfig {
    static let shared = ApplicationConfig()
}

extension ApplicationConfig: ApplicationConfigProtocol {
    var fiatsURL: URL? {
        URL(string: "https://raw.githubusercontent.com/soramitsu/fearless-utils/android/v2/fiat/fiats.json")
    }

    var termsURL: URL {
        URL(string: "https://edgewa.re/privacy")!
    }

    var privacyPolicyURL: URL {
        URL(string: "https://edgewa.re/privacy")!
    }

    var websiteURL: URL {
        URL(string: "https://edgewa.re/")!
    }

    // swiftlint:disable force_cast
    var version: String {
        let bundle = Bundle(for: ApplicationConfig.self)

        let mainVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as! String
        let buildNumber = bundle.infoDictionary?["CFBundleVersion"] as! String

        return "\(mainVersion).\(buildNumber)"
    }

    // swiftlint:enable force_cast

    var opensourceURL: URL {
        URL(string: "https://github.com/finn-exchange/edgeware-android-wallet")!
    }

    // swiftlint:disable force_cast
    var appName: String {
        let bundle = Bundle(for: ApplicationConfig.self)
        return bundle.infoDictionary?["CFBundleDisplayName"] as! String
    }

    // swiftlint:enable force_cast

    var logoURL: URL {
        // swiftlint:disable:next line_length
        let logoString = "https://raw.githubusercontent.com/nova-wallet/branding/master/logos/Nova_Wallet_Horizontal_iOS_Ramp.png"
        return URL(string: logoString)!
    }

    var purchaseAppName: String {
        "Edgeverse Wallet"
    }

    var moonPayApiKey: String {
        "pk_live_Boi6Rl107p7XuJWBL8GJRzGWlmUSoxbz"
    }

    var purchaseRedirect: URL {
        URL(string: "novawallet://novawallet.io/redirect")!
    }

    var phishingListURL: URL {
        URL(string: "https://polkadot.js.org/phishing/address.json")!
    }

    var phishingDAppsURL: URL {
        URL(string: "https://polkadot.js.org/phishing/all.json")!
    }

    var chainListURL: URL {
        #if F_RELEASE
            URL(string: "https://raw.githubusercontent.com/finn-exchange/edgeware-utils/master/chains/v4/chains.json")!
        #else
            URL(string: "https://raw.githubusercontent.com/finn-exchange/edgeware-utils/master/chains/v4/chains_dev.json")!
        #endif
    }

    var dAppsListURL: URL {
        #if F_RELEASE
            URL(string: "https://raw.githubusercontent.com/finn-exchange/edgeware-utils/master/dapps/dapps.json")!
        #else
            URL(string: "https://raw.githubusercontent.com/finn-exchange/edgeware-utils/master/dapps/dapps_dev.json")!
        #endif
    }

    var canDebugDApp: Bool {
        #if F_RELEASE
            false
        #else
            true
        #endif
    }

    var fileCachePath: String {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("files-cache").path
    }

    var commonTypesURL: URL {
        URL(string: "https://raw.githubusercontent.com/finn-exchange/edgeware-utils/master/chains/types/default.json")!
    }

    var learnPayoutURL: URL {
        URL(string: "https://wiki.polkadot.network/docs/en/learn-simple-payouts")!
    }

    var learnControllerAccountURL: URL {
        // swiftlint:disable:next line_length
        URL(string: "https://wiki.polkadot.network/docs/en/maintain-guides-how-to-nominate-polkadot#setting-up-stash-and-controller-keys")!
    }

    var learnRecommendedValidatorsURL: URL {
        URL(string: "https://github.com/nova-wallet/nova-utils/wiki/Recommended-validators-in-Nova-Wallet")!
    }
}
