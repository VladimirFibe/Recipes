import UIKit

class TrendingCell: UICollectionViewCell {
    static let identifier = "TrendingCell"
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
    
    public func configure(with recipe: Recipe) {
        footerView.configure(with: recipe)
        pictureView.configure(with: recipe)
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
