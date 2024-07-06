import UIKit

protocol ContentViewControllerDelegate: AnyObject {
    func didTapActionButton(on viewController: ContentViewController)
    func didTapSkipButton(on viewController: ContentViewController)
    func didTapPageIndicator(at index: Int)
}

class ContentViewController: UIViewController {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let dimmingView = UIView()
    private let titleLabel = UILabel()
    private let actionButton = UIButton()
    private let skipButton = UIButton()
    private let indicatorStackView = UIStackView()
    
    private var showSkipButton: Bool
    private var imageFile: String
    private var whiteText: String
    private var colorText: String
    internal var buttonText: String
    private var pageIndex: Int
    
    weak var delegate: ContentViewControllerDelegate?
    
    init(imageName: String, buttonText: String, showSkipButton: Bool, whiteText: String, colorText: String, pageIndex: Int, delegate: ContentViewControllerDelegate?) {
        self.imageFile = imageName
        self.buttonText = buttonText
        self.showSkipButton = showSkipButton
        self.whiteText = whiteText
        self.colorText = colorText
        self.pageIndex = pageIndex
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
        updatePageIndicator(forPage: pageIndex)
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
        titleLabel.attributedText = createAttributedString(whiteText: whiteText, colorText: colorText)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 52)
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitle(buttonText, for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = UIColor(red: 226/255, green: 62/255, blue: 62/255, alpha: 1)
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: actionButton.titleLabel?.font.pointSize ?? 18)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        actionButton.layer.cornerRadius = 25
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .primaryActionTriggered)
        
        indicatorStackView.translatesAutoresizingMaskIntoConstraints = false
        indicatorStackView.axis = .horizontal
        indicatorStackView.alignment = .center
        indicatorStackView.distribution = .fillEqually
        indicatorStackView.spacing = 10
        
        // Создание индикаторов
        for i in 0..<3 {
            let indicator = UIView()
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.backgroundColor = .white
            indicator.layer.cornerRadius = 5
            indicatorStackView.addArrangedSubview(indicator)
            NSLayoutConstraint.activate([
                indicator.widthAnchor.constraint(equalToConstant: 40),
                indicator.heightAnchor.constraint(equalToConstant: 8)
            ])
            
            // Добавление распознавания нажатия
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(indicatorTapped(_:)))
            indicator.addGestureRecognizer(tapGestureRecognizer)
            indicator.isUserInteractionEnabled = true
            indicator.tag = i
        }
    }
    
    private func layout() {
        view.addSubview(imageView)
        view.addSubview(dimmingView)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(indicatorStackView)
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
            skipButtonContainer.heightAnchor.constraint(equalToConstant: 5).isActive = true
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
            
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.widthAnchor.constraint(equalToConstant: 250),
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
    
    @objc private func indicatorTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        delegate?.didTapPageIndicator(at: tappedView.tag)
    }
    
    // MARK: - Создание атрибутированной строки
    private func createAttributedString(whiteText: String, colorText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: whiteText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        let colorAttributedString = NSAttributedString(string: colorText, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 248/255, green: 200/255, blue: 154/255, alpha: 1)])
        attributedString.append(colorAttributedString)
        return attributedString
    }
    
    // MARK: - Обновление индикатора страниц
    func updatePageIndicator(forPage index: Int) {
        for (i, view) in indicatorStackView.arrangedSubviews.enumerated() {
            view.backgroundColor = (i == index) ? UIColor(red: 250/255, green: 155/255, blue: 177/255, alpha: 1) : .white
        }
    }
}
