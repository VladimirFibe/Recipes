import UIKit

protocol ContentViewControllerDelegate: AnyObject {
    func didTapActionButton(on viewController: ContentViewController)
    func didTapSkipButton(on viewController: ContentViewController)
}

class ContentViewController: UIViewController {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let dimmingView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionButton = UIButton()
    private let skipButton = UIButton()
    
    private var showSkipButton: Bool
    private var imageFile: String
    private var titleText: String
    private var subtitleText: String
    internal var buttonText: String
    private var isFirstPage: Bool
    
    weak var delegate: ContentViewControllerDelegate?
    
    init(imageName: String, titleText: String, subtitleText: String, buttonText: String, showSkipButton: Bool, isFirstPage: Bool, delegate: ContentViewControllerDelegate?) {
        self.imageFile = imageName
        self.titleText = titleText
        self.subtitleText = subtitleText
        self.buttonText = buttonText
        self.isFirstPage = isFirstPage
        self.showSkipButton = showSkipButton
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    // MARK: - Настройка стиля и компоновки
    private func style() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageFile)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = titleText
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = subtitleText
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitle(buttonText, for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = UIColor(red: 226/255, green: 62/255, blue: 62/255, alpha: 1)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        actionButton.layer.cornerRadius = 25
        
        if showSkipButton {
            skipButton.translatesAutoresizingMaskIntoConstraints = false
            skipButton.setTitle("Skip", for: .normal)
            skipButton.setTitleColor(.white, for: .normal)
            skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .primaryActionTriggered)
        }
    }
    
    private func layout() {
        view.addSubview(imageView)
        view.addSubview(dimmingView)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(actionButton)
        
        if showSkipButton {
            let skipButtonContainer = UIView()
            skipButtonContainer.translatesAutoresizingMaskIntoConstraints = false
            skipButtonContainer.addSubview(skipButton)
            
            NSLayoutConstraint.activate([
                skipButton.topAnchor.constraint(equalTo: skipButtonContainer.topAnchor),
                skipButton.bottomAnchor.constraint(equalTo: skipButtonContainer.bottomAnchor),
                skipButton.centerXAnchor.constraint(equalTo: skipButtonContainer.centerXAnchor),
                skipButton.leadingAnchor.constraint(equalTo: skipButtonContainer.leadingAnchor),
                skipButton.trailingAnchor.constraint(equalTo: skipButtonContainer.trailingAnchor)
            ])
            
            stackView.addArrangedSubview(skipButtonContainer)
            skipButtonContainer.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: 16),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    // MARK: - Действия кнопок
    @objc private func buttonTapped() {
        delegate?.didTapActionButton(on: self)
        // Анимация кнопки при нажатии
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                self.actionButton.alpha = 0.2
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.6) {
                self.actionButton.alpha = 1.0
            }
        }, completion: nil)
    }
    
    @objc private func skipButtonTapped() {
        delegate?.didTapSkipButton(on: self)
    }
}
