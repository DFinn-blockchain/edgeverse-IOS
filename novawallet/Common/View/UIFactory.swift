import UIKit
import SoraUI

struct UIConstants {
    static let accessoryBarHeight: CGFloat = 44.0
    static let accessoryItemsSpacing: CGFloat = 12.0
    static let actionBottomInset: CGFloat = 16.0
    static let actionHeight: CGFloat = 52.0
    static let cellHeight: CGFloat = 48
    static let expandableViewHeight: CGFloat = 50.0
    static let formSeparatorWidth: CGFloat = 0.5
    static let horizontalInset: CGFloat = 16.0
    static let mainAccessoryActionsSpacing: CGFloat = 16.0
    static let networkFeeViewDefaultHeight = 132.0
    static let normalAddressIconSize = CGSize(width: 32.0, height: 32.0)
    static let separatorHeight: CGFloat = 1 / UIScreen.main.scale
    static let skeletonBigRowSize = CGSize(width: 72.0, height: 12.0)
    static let skeletonSmallRowSize = CGSize(width: 57.0, height: 6.0)
    static let smallAddressIconSize = CGSize(width: 18.0, height: 18.0)
    static let tableHeaderHeight: CGFloat = 40.0
    static let triangularedIconLargeRadius: CGFloat = 12.0
    static let triangularedIconSmallRadius: CGFloat = 9.0
    static let triangularedViewHeight: CGFloat = 52.0
    static let verticalTitleInset: CGFloat = 8.0
    static let navigationAccountIconSize: CGFloat = 40.0
}

enum AccountViewMode {
    case options
    case selection
}

protocol UIFactoryProtocol {
    func createMainActionButton() -> TriangularedButton
    func createAccessoryButton() -> TriangularedButton
    func createDetailsView(
        with layout: DetailsTriangularedView.Layout,
        filled: Bool
    ) -> DetailsTriangularedView
    func createExpandableActionControl() -> ExpandableActionControl
    func createTitledMnemonicView(_ title: String?, icon: UIImage?) -> TitledMnemonicView
    func createMultilinedTriangularedView() -> MultilineTriangularedView
    func createRoundedBackgroundView(filled: Bool) -> RoundedView
    func createSeparatorView() -> UIView
    func createBorderedContainerView() -> BorderedContainerView
    func createActionsAccessoryView(
        for actions: [ViewSelectorAction],
        doneAction: ViewSelectorAction,
        target: Any?,
        spacing: CGFloat
    ) -> UIToolbar

    func createCommonInputView() -> CommonInputView
    func createAmountInputView(filled: Bool) -> AmountInputView

    func createAmountAccessoryView(
        for delegate: AmountInputAccessoryViewDelegate?,
        locale: Locale
    ) -> UIToolbar

    func createAccountView(for mode: AccountViewMode, filled: Bool) -> DetailsTriangularedView
    func createIdentityView(isSingleTitle: Bool) -> DetailsTriangularedView

    func createNetworkFeeView() -> NetworkFeeView

    func createNetworkFeeConfirmView() -> NetworkFeeConfirmView

    func createTitleValueView() -> TitleValueView

    func createIconTitleValueView() -> IconTitleValueView

    func createTitleValueSelectionView() -> TitleValueSelectionView

    func createHintView() -> HintView

    func createLearnMoreView() -> LearnMoreView

    func createInfoIndicatingView() -> ImageWithTitleView

    func createChainAssetSelectionView() -> ChainAssetSelectionControl

    func createAnimatedTextField() -> AnimatedTextField

    func createBorderSubtitleActionView() -> BorderedSubtitleActionView
}

extension UIFactoryProtocol {
    func createAccountView() -> DetailsTriangularedView {
        createAccountView(for: .options, filled: false)
    }

    func createNovaLearnMoreView() -> LearnMoreView {
        let view = createLearnMoreView()
        view.iconView.image = R.image.iconNovaSmall()
        return view
    }

    func createRoundedBackgroundView() -> RoundedView {
        createRoundedBackgroundView(filled: false)
    }
}

// swiftlint:disable:next type_body_length
final class UIFactory: UIFactoryProtocol {
    static let `default` = UIFactory()

    func createMainActionButton() -> TriangularedButton {
        let button = TriangularedButton()
        button.applyDefaultStyle()
        return button
    }

    func createAccessoryButton() -> TriangularedButton {
        let button = TriangularedButton()
        button.applyAccessoryStyle()
        return button
    }

    func createDetailsView(
        with layout: DetailsTriangularedView.Layout,
        filled: Bool
    ) -> DetailsTriangularedView {
        let view = DetailsTriangularedView()
        view.layout = layout

        if !filled {
            view.fillColor = .clear
            view.highlightedFillColor = .clear
            view.strokeColor = R.color.colorStrokeGray()!
            view.highlightedStrokeColor = R.color.colorStrokeGray()!
            view.borderWidth = 1.0
        } else {
            view.fillColor = R.color.colorDarkGray()!
            view.highlightedFillColor = R.color.colorDarkGray()!
            view.strokeColor = .clear
            view.highlightedStrokeColor = .clear
            view.borderWidth = 0.0
        }

        switch layout {
        case .largeIconTitleSubtitle, .singleTitle:
            view.iconRadius = UIConstants.triangularedIconLargeRadius
        case .smallIconTitleSubtitle:
            view.iconRadius = UIConstants.triangularedIconSmallRadius
        }

        view.titleLabel.textColor = R.color.colorLightGray()!
        view.titleLabel.font = UIFont.p2Paragraph
        view.subtitleLabel?.textColor = R.color.colorWhite()!
        view.subtitleLabel?.font = UIFont.p1Paragraph
        view.contentInsets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)

        return view
    }

    func createExpandableActionControl() -> ExpandableActionControl {
        let view = ExpandableActionControl()
        view.layoutType = .flexible
        view.titleLabel.textColor = R.color.colorWhite()
        view.titleLabel.font = UIFont.p1Paragraph
        view.plusIndicator.strokeColor = R.color.colorWhite()!

        return view
    }

    func createTitledMnemonicView(_ title: String?, icon: UIImage?) -> TitledMnemonicView {
        let view = TitledMnemonicView()

        if let icon = icon {
            view.iconView.image = icon
        }

        if let title = title {
            view.titleLabel.textColor = R.color.colorLightGray()!
            view.titleLabel.font = UIFont.p1Paragraph
            view.titleLabel.text = title
        }

        view.contentView.indexTitleColorInColumn = R.color.colorGray()!
        view.contentView.wordTitleColorInColumn = R.color.colorWhite()!

        view.contentView.indexFontInColumn = .p0Digits
        view.contentView.wordFontInColumn = .p0Paragraph

        return view
    }

    func createMultilinedTriangularedView() -> MultilineTriangularedView {
        let view = MultilineTriangularedView()
        view.backgroundView.fillColor = R.color.colorDarkGray()!
        view.backgroundView.highlightedFillColor = R.color.colorDarkGray()!
        view.backgroundView.strokeColor = .clear
        view.backgroundView.highlightedStrokeColor = .clear
        view.backgroundView.strokeWidth = 0.0

        view.titleLabel.textColor = R.color.colorLightGray()!
        view.titleLabel.font = UIFont.p2Paragraph
        view.subtitleLabel?.textColor = R.color.colorWhite()!
        view.subtitleLabel?.font = UIFont.p1Paragraph
        view.contentInsets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)

        return view
    }

    func createSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = R.color.colorDarkGray()!
        return view
    }

    func createBorderedContainerView() -> BorderedContainerView {
        let view = BorderedContainerView()
        view.borderType = .bottom
        view.strokeWidth = UIConstants.separatorHeight
        view.strokeColor = R.color.colorDarkGray()!
        return view
    }

    func createActionsAccessoryView(
        for _: [ViewSelectorAction],
        doneAction _: ViewSelectorAction,
        target _: Any?,
        spacing _: CGFloat
    ) -> UIToolbar {
        let frame = CGRect(
            x: 0.0,
            y: 0.0,
            width: UIScreen.main.bounds.width,
            height: UIConstants.accessoryBarHeight
        )

        let toolBar = UIToolbar(frame: frame)

        return toolBar
    }

    func createAmountAccessoryView(
        for delegate: AmountInputAccessoryViewDelegate?,
        locale: Locale
    ) -> UIToolbar {
        let frame = CGRect(
            x: 0.0,
            y: 0.0,
            width: UIScreen.main.bounds.width,
            height: UIConstants.accessoryBarHeight
        )

        let toolBar = AmountInputAccessoryView(frame: frame)
        toolBar.actionDelegate = delegate

        let maxTitle = R.string.localizable.commonMax(preferredLanguages: locale.rLanguages)
        let actions: [ViewSelectorAction] = [
            ViewSelectorAction(title: maxTitle.uppercased(), selector: #selector(toolBar.actionSelect100)),
            ViewSelectorAction(title: "75%", selector: #selector(toolBar.actionSelect75)),
            ViewSelectorAction(title: "50%", selector: #selector(toolBar.actionSelect50)),
            ViewSelectorAction(title: "25%", selector: #selector(toolBar.actionSelect25))
        ]

        let doneTitle = R.string.localizable.commonDone(preferredLanguages: locale.rLanguages)
        let doneAction = ViewSelectorAction(
            title: doneTitle,
            selector: #selector(toolBar.actionSelectDone)
        )

        let spacing: CGFloat

        if toolBar.isAdaptiveWidthDecreased {
            spacing = UIConstants.accessoryItemsSpacing * toolBar.designScaleRatio.width
        } else {
            spacing = UIConstants.accessoryItemsSpacing
        }

        return createActionsAccessoryView(
            for: toolBar,
            actions: actions,
            doneAction: doneAction,
            target: toolBar,
            spacing: spacing
        )
    }

    func createCommonInputView() -> CommonInputView {
        CommonInputView()
    }

    func createAmountInputView(filled: Bool) -> AmountInputView {
        let amountInputView = AmountInputView()

        if !filled {
            amountInputView.triangularedBackgroundView?.strokeColor = R.color.colorWhite()!
            amountInputView.triangularedBackgroundView?.highlightedStrokeColor = R.color.colorWhite()!
            amountInputView.triangularedBackgroundView?.strokeWidth = 1.0
            amountInputView.triangularedBackgroundView?.fillColor = .clear
            amountInputView.triangularedBackgroundView?.highlightedFillColor = .clear
        } else {
            amountInputView.triangularedBackgroundView?.strokeWidth = 0.0
            amountInputView.triangularedBackgroundView?.fillColor = R.color.colorDarkGray()!
            amountInputView.triangularedBackgroundView?.highlightedFillColor = R.color.colorDarkGray()!
        }

        amountInputView.titleLabel.textColor = R.color.colorLightGray()
        amountInputView.titleLabel.font = .p2Paragraph
        amountInputView.priceLabel.textColor = R.color.colorLightGray()
        amountInputView.priceLabel.font = .p2Paragraph
        amountInputView.symbolLabel.textColor = R.color.colorWhite()
        amountInputView.symbolLabel.font = .h4Title
        amountInputView.balanceLabel.textColor = R.color.colorLightGray()
        amountInputView.balanceLabel.font = .p2Paragraph
        amountInputView.textField.font = .h4Title
        amountInputView.textField.textColor = R.color.colorWhite()
        amountInputView.textField.tintColor = R.color.colorWhite()
        amountInputView.verticalSpacing = 2.0
        amountInputView.iconRadius = 12.0
        amountInputView.contentInsets = UIEdgeInsets(
            top: 8.0,
            left: UIConstants.horizontalInset,
            bottom: 8.0,
            right: UIConstants.horizontalInset
        )

        amountInputView.textField.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [
                .foregroundColor: R.color.colorWhite()!.withAlphaComponent(0.5),
                .font: UIFont.h4Title
            ]
        )

        amountInputView.textField.keyboardType = .decimalPad

        return amountInputView
    }

    private func createActionsAccessoryView(
        for toolBar: UIToolbar,
        actions: [ViewSelectorAction],
        doneAction: ViewSelectorAction,
        target: Any?,
        spacing: CGFloat
    ) -> UIToolbar {
        toolBar.isTranslucent = false

        let background = UIImage.background(from: R.color.colorAlmostBlack()!)
        toolBar.setBackgroundImage(
            background,
            forToolbarPosition: .any,
            barMetrics: .default
        )

        let actionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.colorWhite()!,
            .font: UIFont.p1Paragraph
        ]

        let barItems = actions.reduce([UIBarButtonItem]()) { result, action in
            let barItem = UIBarButtonItem(
                title: action.title,
                style: .plain,
                target: target,
                action: action.selector
            )
            barItem.setTitleTextAttributes(actionAttributes, for: .normal)
            barItem.setTitleTextAttributes(actionAttributes, for: .highlighted)

            if result.isEmpty {
                return [barItem]
            } else {
                let fixedSpacing = UIBarButtonItem(
                    barButtonSystemItem: .fixedSpace,
                    target: nil,
                    action: nil
                )
                fixedSpacing.width = spacing

                return result + [fixedSpacing, barItem]
            }
        }

        let flexibleSpacing = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let doneItem = UIBarButtonItem(
            title: doneAction.title,
            style: .done,
            target: target,
            action: doneAction.selector
        )

        let doneAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: R.color.colorWhite()!,
            .font: UIFont.h5Title
        ]

        doneItem.setTitleTextAttributes(doneAttributes, for: .normal)
        doneItem.setTitleTextAttributes(doneAttributes, for: .highlighted)

        toolBar.setItems(barItems + [flexibleSpacing, doneItem], animated: true)

        return toolBar
    }

    func createAccountView(for mode: AccountViewMode, filled: Bool) -> DetailsTriangularedView {
        let view = createDetailsView(with: .smallIconTitleSubtitle, filled: filled)
        view.subtitleLabel?.lineBreakMode = .byTruncatingMiddle

        switch mode {
        case .options:
            view.actionImage = R.image.iconMore()
        case .selection:
            view.actionImage = R.image.iconSmallArrowDown()
        }

        view.highlightedFillColor = R.color.colorHighlightedAccent()!
        view.borderWidth = 1
        return view
    }

    func createIdentityView(isSingleTitle: Bool) -> DetailsTriangularedView {
        let view = DetailsTriangularedView()

        view.titleLabel.textColor = R.color.colorWhite()!
        view.titleLabel.font = UIFont.p1Paragraph

        if isSingleTitle {
            view.layout = .singleTitle
            view.titleLabel.lineBreakMode = .byTruncatingMiddle
        } else {
            view.layout = .largeIconTitleSubtitle

            view.subtitleLabel?.textColor = R.color.colorLightGray()!
            view.subtitleLabel?.font = UIFont.p2Paragraph

            view.titleLabel.lineBreakMode = .byTruncatingTail
            view.subtitleLabel?.lineBreakMode = .byTruncatingMiddle
        }

        view.actionImage = R.image.iconMore()

        view.iconRadius = 16.0

        view.fillColor = .clear
        view.highlightedFillColor = R.color.colorHighlightedAccent()!
        view.strokeColor = R.color.colorStrokeGray()!
        view.highlightedStrokeColor = R.color.colorStrokeGray()!
        view.borderWidth = 1.0

        view.contentInsets = UIEdgeInsets(top: 8.0, left: 11.0, bottom: 8.0, right: 16.0)

        return view
    }

    func createNetworkFeeView() -> NetworkFeeView {
        NetworkFeeView()
    }

    // TODO: Rename when fully move to this method
    func createNetwork26FeeView() -> NetworkFeeView {
        let view = NetworkFeeView()
        view.borderType = []

        view.style = NetworkFeeView.ViewStyle(
            titleColor: R.color.colorTransparentText()!,
            titleFont: .regularFootnote,
            tokenColor: R.color.colorWhite()!,
            tokenFont: .regularFootnote,
            fiatColor: R.color.colorTransparentText()!,
            fiatFont: .caption1
        )

        return view
    }

    func createNetworkFeeConfirmView() -> NetworkFeeConfirmView {
        NetworkFeeConfirmView(
            frame: CGRect(
                x: 0.0, y: 0.0,
                width: 0.0, height: UIConstants.networkFeeViewDefaultHeight
            )
        )
    }

    func createTitleValueView() -> TitleValueView {
        TitleValueView()
    }

    func createIconTitleValueView() -> IconTitleValueView {
        IconTitleValueView()
    }

    func createHintView() -> HintView {
        HintView()
    }

    func createLearnMoreView() -> LearnMoreView {
        let view = LearnMoreView()
        view.contentInsets = UIEdgeInsets(
            top: 0.0,
            left: UIConstants.horizontalInset,
            bottom: 0.0,
            right: UIConstants.horizontalInset
        )
        return view
    }

    func createTitleValueSelectionView() -> TitleValueSelectionView {
        TitleValueSelectionView()
    }

    func createInfoIndicatingView() -> ImageWithTitleView {
        let view = ImageWithTitleView()
        view.titleColor = R.color.colorLightGray()
        view.titleFont = .p1Paragraph
        view.layoutType = .horizontalLabelFirst
        view.spacingBetweenLabelAndIcon = 5.0
        view.iconImage = R.image.iconInfoFilled()
        return view
    }

    func createChainAssetSelectionView() -> ChainAssetSelectionControl {
        let view = ChainAssetSelectionControl()
        view.fillColor = .clear
        view.highlightedFillColor = R.color.colorHighlightedAccent()!
        view.titleLabel.textColor = R.color.colorWhite()
        view.titleLabel.font = .p1Paragraph
        view.subtitleLabel?.textColor = R.color.colorLightGray()
        view.subtitleLabel?.font = .p2Paragraph
        view.iconBackgroundView.fillColor = R.color.colorBlack24()!
        view.iconBackgroundView.strokeColor = R.color.colorWhite16()!
        view.iconBackgroundView.strokeWidth = 0.5
        view.actionImage = R.image.iconMore()
        view.contentInsets = UIEdgeInsets(top: 13.0, left: 19.0, bottom: 13.0, right: 19.0)
        view.titleAdditionalTopMargin = -5
        view.subtitleAdditionalBottomMargin = -5
        view.iconRadius = 13.0
        view.horizontalSpacing = 19.0
        return view
    }

    func createRoundedBackgroundView(filled: Bool) -> RoundedView {
        let view = RoundedView()
        view.cornerRadius = 12.0

        if filled {
            view.strokeColor = .clear
            view.highlightedStrokeColor = .clear
            view.fillColor = R.color.colorDarkGray()!
            view.highlightedFillColor = R.color.colorDarkGray()!
        } else {
            view.strokeColor = R.color.colorTransparentText()!
            view.highlightedStrokeColor = R.color.colorTransparentText()!
            view.fillColor = .clear
            view.highlightedFillColor = .clear
        }

        view.strokeWidth = 1.0
        view.shadowOpacity = 0.0
        return view
    }

    func createAnimatedTextField() -> AnimatedTextField {
        let textField = AnimatedTextField()
        textField.contentInsets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 6.0, right: 16.0)
        textField.titleFont = .p2Paragraph
        textField.placeholderFont = .p1Paragraph
        textField.textFont = .p1Paragraph
        textField.titleColor = R.color.colorLightGray()!
        textField.placeholderColor = R.color.colorLightGray()!
        textField.textColor = R.color.colorWhite()
        textField.cursorColor = R.color.colorWhite()!
        return textField
    }

    func createBorderSubtitleActionView() -> BorderedSubtitleActionView {
        let view = BorderedSubtitleActionView()
        view.fillColor = .clear
        view.highlightedFillColor = R.color.colorAccentSelected()!
        view.strokeColor = R.color.colorGray()!
        view.highlightedStrokeColor = .clear
        view.strokeWidth = 1.0
        view.shadowOpacity = 0.0
        view.actionControl.contentView.titleLabel.textColor = R.color.colorLightGray()
        view.actionControl.contentView.titleLabel.font = .p2Paragraph
        view.actionControl.contentView.subtitleLabelView.textColor = R.color.colorWhite()
        view.actionControl.contentView.subtitleLabelView.font = .p1Paragraph
        view.actionControl.layoutType = .flexible
        return view
    }
}
