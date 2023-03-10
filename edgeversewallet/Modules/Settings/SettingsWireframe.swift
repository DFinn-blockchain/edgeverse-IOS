import Foundation
import UIKit

final class SettingsWireframe: SettingsWireframeProtocol, AuthorizationPresentable {
    func showAccountDetails(for walletId: String, from view: ControllerBackedProtocol?) {
        guard let accountManagement = AccountManagementViewFactory.createView(for: walletId) else {
            return
        }

        accountManagement.controller.hidesBottomBarWhenPushed = true

        view?.controller.navigationController?.pushViewController(
            accountManagement.controller,
            animated: true
        )
    }

    func showPincodeChange(from view: ControllerBackedProtocol?) {
        authorize(animated: true, cancellable: true) { [weak self] completed in
            if completed {
                self?.showPinSetup(from: view)
            }
        }
    }

    func showAccountSelection(from view: ControllerBackedProtocol?) {
        guard let accountManagement = WalletManagementViewFactory.createViewForSettings() else {
            return
        }

        accountManagement.controller.hidesBottomBarWhenPushed = true

        view?.controller.navigationController?.pushViewController(
            accountManagement.controller,
            animated: true
        )
    }

    func showLanguageSelection(from view: ControllerBackedProtocol?) {
        guard let languageSelection = LanguageSelectionViewFactory.createView() else {
            return
        }

        if let navigationController = view?.controller.navigationController {
            languageSelection.controller.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(languageSelection.controller, animated: true)
        }
    }

    func showSelectCurrency(
        from view: ControllerBackedProtocol?,
        with wallet: MetaAccountModel
    ) {
        guard let controller = SelectCurrencyAssembly.configureModule(
            with: wallet,
            isModal: false
        )?.view.controller else { return }
        controller.hidesBottomBarWhenPushed = true
        view?.controller.navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: Private

    private func showPinSetup(from view: ControllerBackedProtocol?) {
        guard let pinSetup = PinViewFactory.createPinChangeView() else {
            return
        }

        pinSetup.controller.hidesBottomBarWhenPushed = true

        view?.controller.navigationController?.pushViewController(
            pinSetup.controller,
            animated: true
        )
    }
}
