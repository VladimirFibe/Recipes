import UIKit

class DurationLabel: UIView {
    private let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
    private lazy var blurView = UIVisualEffectView(effect: blurEffect)
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlurView()
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
    
    private func setupLabel() {
        addSubview(label)
        label.text = "15:10"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBackground
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
