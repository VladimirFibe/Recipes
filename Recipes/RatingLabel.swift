import UIKit

class RatingLabel: UIView {
    private let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
    private lazy var blurView = UIVisualEffectView(effect: blurEffect)
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlurView()
        setupImageView()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBlurView() {
        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 8
        blurView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.image = UIImage(named: "star12")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    private func setupLabel() {
        addSubview(label)
        label.text = "4,5"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBackground
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 3),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}
