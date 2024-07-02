import UIKit

class TrendingCell: UICollectionViewCell {
    private let pictureView = PictureView()
    private let footerView = TrendingFooterView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPictureView()
        setupFooterView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPictureView() {
        contentView.addSubview(pictureView)
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func setupFooterView() {
        contentView.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: pictureView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: pictureView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor)
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
