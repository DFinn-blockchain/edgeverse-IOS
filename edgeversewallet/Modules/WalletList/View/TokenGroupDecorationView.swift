import UIKit

final class TokenGroupDecorationView: UICollectionReusableView {
    let backgroundView: TriangularedView = {
        let view = TriangularedView()
        view.strokeWidth = 1
        view.fillColor = .clear
        view.strokeColor = R.color.colorGray()!
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
