import UIKit

final class DAppListDecorationView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
//        backgroundView.backgroundColor = R.color.colorBlack()
//        addSubview(backgroundView)
//        backgroundView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
}
