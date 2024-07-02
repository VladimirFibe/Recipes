import UIKit

class TrendingCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let starLabel = RatingLabel()
    private let bookmarkView = BookmarkView()
    private let timeLabel = DurationLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupTitleLabel()
        setupAvatarImageView()
        setupNameLabel()
        setupStarLabel()
        setupBookmarkView()
        setupTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.image = .image4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.text = "How to sharwama at home"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        ])
    }
    
    private func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.image = .creator
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 32),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "By Zeelicious foods"
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8)
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
    
    private func setupTimeLabel() {
        imageView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            timeLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8)
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
