import Foundation
import UIKit.UIImage

enum SettingsRow {
    case wallets
    case language
    case changePin
    case website
    case github
    case terms
    case privacyPolicy
    case currency
}

extension SettingsRow {
    // swiftlint:disable:next cyclomatic_complexity
    func title(for locale: Locale) -> String {
        switch self {
        case .wallets:
            return R.string.localizable.profileWalletsTitle(preferredLanguages: locale.rLanguages)
        case .language:
            return R.string.localizable.profileLanguageTitle(preferredLanguages: locale.rLanguages)
        case .changePin:
            return R.string.localizable.profilePincodeChangeTitle(preferredLanguages: locale.rLanguages)
        case .github:
            return R.string.localizable.aboutGithub(preferredLanguages: locale.rLanguages)
        case .terms:
            return R.string.localizable.aboutTerms(preferredLanguages: locale.rLanguages)
        case .privacyPolicy:
            return R.string.localizable.aboutPrivacy(preferredLanguages: locale.rLanguages)
        case .website:
            return R.string.localizable.aboutWebsite(preferredLanguages: locale.rLanguages)
        case .currency:
            return R.string.localizable.currencyTitle(preferredLanguages: locale.rLanguages)
        }
    }

    var icon: UIImage? {
        switch self {
        case .wallets:
            return R.image.iconSettingsWallet()
        case .language:
            return R.image.iconSettingsLanguage()
        case .changePin:
            return R.image.iconSettingsPin()
        case .website:
            return R.image.iconSettingsWebsite()
        case .github:
            return R.image.iconAboutGithub()
        case .terms:
            return R.image.ic_description()!
        case .privacyPolicy:
            return R.image.ic_description()!
        case .currency:
            return R.image.iconCurrency()!
        }
    }
}
