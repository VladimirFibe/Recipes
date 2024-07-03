import UIKit

final class BookmarkView: UIView {
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.image = .bookmarkInactive24
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           imageView.widthAnchor.constraint(equalToConstant: 24),
           imageView.heightAnchor.constraint(equalTo: widthAnchor),
           widthAnchor.constraint(equalToConstant: 32),
           heightAnchor.constraint(equalTo: widthAnchor),
           imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
           imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with active: Bool) {
        imageView.image = active ? .bookmarkActive24 : .bookmarkInactive24
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
