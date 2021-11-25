import UIKit

class AccountImportBaseView: UIView {
    var locale: Locale? {
        didSet {
            setupLocalization()
        }
    }

    func setupLocalization() {
        fatalError("Must be implemeted by subsclass")
    }
}
