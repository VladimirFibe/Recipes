import UIKit

final class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"
    private let titleLabel = UILabel()
    private let button = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with text: String, target: Any?, action: Selector) {
        titleLabel.text = text
        button.addTarget(target, action: action, for: .primaryActionTriggered)
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    private func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString(stringLiteral: "See all")
        attributedTitle.font = .custom(font: .bold, size: 14)
        config.attributedTitle = attributedTitle
        config.baseForegroundColor = UIColor(red: 0xE2/255, green: 0x3E/255, blue: 0x3E/255, alpha: 1.0)
        config.image = UIImage(named: "arrowRight20")
        config.imagePlacement = .trailing
        config.imagePadding = 3
        button.configuration = config
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
}
