import Foundation
import SoraFoundation
import SubstrateSdk
import IrohaCrypto

final class SettingsViewModelFactory: SettingsViewModelFactoryProtocol {
    let iconGenerator: IconGenerating

    init(iconGenerator: IconGenerating) {
        self.iconGenerator = iconGenerator
    }

    func createAccountViewModel(for wallet: MetaAccountModel) -> SettingsAccountViewModel {
        let icon = try? iconGenerator.generateFromAccountId(wallet.substrateAccountId)
            .imageWithFillColor(
                R.color.colorWhite()!,
                size: UIConstants.normalAddressIconSize,
                contentScale: UIScreen.main.scale
            )

        return SettingsAccountViewModel(name: wallet.name, icon: icon)
    }

    func createSectionViewModels(
        currency _: Currency?,
        language: Language?, locale: Locale
    ) -> [(SettingsSection, [SettingsCellViewModel])] {
        [
            (.general, [createCommonViewViewModel(row: .wallets, locale: locale),
//                        createCurrencyViewModel(from: currency, locale: locale),
                        createLanguageViewModel(from: language, locale: locale),
                        createCommonViewViewModel(row: .changePin, locale: locale)]),
            (.about, [
                createCommonViewViewModel(row: .website, locale: locale),
                createCommonViewViewModel(row: .github, locale: locale),
                createCommonViewViewModel(row: .terms, locale: locale),
                createCommonViewViewModel(row: .privacyPolicy, locale: locale)
            ])
        ]
    }

    private func createCommonViewViewModel(
        row: SettingsRow,
        locale: Locale
    ) -> SettingsCellViewModel {
        SettingsCellViewModel(
            row: row,
            title: row.title(for: locale),
            icon: row.icon,
            accessoryTitle: nil
        )
    }

    private func createLanguageViewModel(from language: Language?, locale: Locale) -> SettingsCellViewModel {
        let title = R.string.localizable
            .profileLanguageTitle(preferredLanguages: locale.rLanguages)
        let subtitle = language?.title(in: locale)?.capitalized
        let viewModel = SettingsCellViewModel(
            row: .language,
            title: title,
            icon: SettingsRow.language.icon,
            accessoryTitle: subtitle
        )

        return viewModel
    }

    private func createCurrencyViewModel(from currency: Currency?, locale: Locale) -> SettingsCellViewModel {
        let title = R.string.localizable
            .currencyTitle(preferredLanguages: locale.rLanguages)
        let subtitle = currency?.name
        let viewModel = SettingsCellViewModel(
            row: .currency,
            title: R.string.localizable.currencyTitle(preferredLanguages: locale.rLanguages),
            icon: SettingsRow.currency.icon,
            accessoryTitle: subtitle
        )

        return viewModel
    }
}
