import UIKit
import SubstrateSdk

final class AccountPickerTableViewCell: UITableViewCell, ModalPickerCellProtocol {
    typealias Model = AccountPickerViewModel

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var iconView: PolkadotIconView!
    @IBOutlet private var checkmarkImageView: UIImageView!

    var checkmarked: Bool {
        get {
            !checkmarkImageView.isHidden
        }

        set {
            checkmarkImageView.isHidden = !newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = R.color.colorAccentSelected()!
        self.selectedBackgroundView = selectedBackgroundView
    }

    func bind(model: Model) {
        titleLabel.text = model.title
        iconView.bind(icon: model.icon)
    }
}