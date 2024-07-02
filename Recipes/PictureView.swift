import UIKit

class PictureView: UIView {
    private let imageView = UIImageView()
    private let starLabel = RatingLabel()
    private let bookmarkView = BookmarkView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupStarLabel()
        setupBookmarkView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.image = .image4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    private func setupStarLabel() {
        imageView.addSubview(starLabel)
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            starLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
        ])
    }
    
    private func setupBookmarkView() {
        imageView.addSubview(bookmarkView)
        bookmarkView.configure(with: true)
        bookmarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            bookmarkView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
        ])
    }
}
