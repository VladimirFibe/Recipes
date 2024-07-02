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
        imageView.image = .star12
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

@available(iOS 17.0, *)
#Preview {
    ViewController()
}

//var view = UIView()
//view.frame = CGRect(x: 0, y: 0, width: 58, height: 27.6)
//view.layer.backgroundColor = UIColor(red: 0.188, green: 0.188, blue: 0.188, alpha: 0.3).cgColor
//view.layer.cornerRadius = 8
//
//var parent = self.view!
//parent.addSubview(view)
//view.translatesAutoresizingMaskIntoConstraints = false
//view.widthAnchor.constraint(equalToConstant: 58).isActive = true
//view.heightAnchor.constraint(equalToConstant: 27.6).isActive = true
//view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
//view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 0).isActive = true
