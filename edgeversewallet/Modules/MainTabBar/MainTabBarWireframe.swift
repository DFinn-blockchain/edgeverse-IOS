import Foundation
import CommonWallet

final class MainTabBarWireframe: MainTabBarWireframeProtocol {
    func presentAccountImport(on view: MainTabBarViewProtocol?) {
        guard let tabBarController = view?.controller else {
            return
        }

        guard canPresentImport(on: tabBarController) else {
            return
        }

        guard let importController = AccountImportViewFactory
            .createViewForAdding(for: .keystore)?.controller
        else {
            return
        }

        let navigationController = FearlessNavigationController(rootViewController: importController)

        let presentingController = tabBarController.topModalViewController
        presentingController.present(navigationController, animated: true, completion: nil)
    }

    // MARK: Private

    private func canPresentImport(on view: UIViewController) -> Bool {
        if isAuthorizing || isAlreadyImporting(on: view) {
            return false
        }

        return true
    }

    private func isAlreadyImporting(on view: UIViewController) -> Bool {
        let topViewController = view.topModalViewController
        let topNavigationController: UINavigationController?

        if let navigationController = topViewController as? UINavigationController {
            topNavigationController = navigationController
        } else if let tabBarController = topViewController as? UITabBarController {
            topNavigationController = tabBarController.selectedViewController as? UINavigationController
        } else {
            topNavigationController = nil
        }

        return topNavigationController?.viewControllers.contains {
            if ($0 as? OnboardingMainViewProtocol) != nil || ($0 as? AccountImportViewProtocol) != nil {
                return true
            } else {
                return false
            }
        } ?? false
    }
}
