import UIKit

class IntroViewController: UIViewController {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let dimmingView = UIView()
    private let topStackView = UIStackView()
    private let starImageView = UIImageView()
    private let smallLabel = UILabel()
    private let largeLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let actionButton = UIButton()
    
    init() {
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
        imageView.image = UIImage(named: "onboarding")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.spacing = 5
        
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .black
        
        let boldText = "100k+"
        let regularText = " Premium recipes"
        let attributedString = NSMutableAttributedString(string: boldText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedString.append(NSAttributedString(string: regularText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        
        smallLabel.translatesAutoresizingMaskIntoConstraints = false
        smallLabel.attributedText = attributedString
        smallLabel.textColor = .white
        
        largeLabel.translatesAutoresizingMaskIntoConstraints = false
        largeLabel.text = "Best \n Recipe"
        largeLabel.font = UIFont.boldSystemFont(ofSize: 52)
        largeLabel.numberOfLines = 2
        largeLabel.textAlignment = .center
        largeLabel.textColor = .white
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Find best recipes for cooking"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitle("Get Started", for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: actionButton.titleLabel?.font.pointSize ?? 18)
        actionButton.backgroundColor = UIColor(red: 226/255, green: 62/255, blue: 62/255, alpha: 1)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        actionButton.layer.cornerRadius = 8
    }
    
    private func layout() {
        view.addSubview(imageView)
        view.addSubview(dimmingView)
        view.addSubview(stackView)
        view.addSubview(topStackView)
        
        topStackView.addArrangedSubview(starImageView)
        topStackView.addArrangedSubview(smallLabel)
        stackView.addArrangedSubview(largeLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(actionButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            actionButton.heightAnchor.constraint(equalToConstant: 56),
            actionButton.widthAnchor.constraint(equalToConstant: 156),
        ])
    }
    
    // MARK: - Действия кнопок
    @objc private func buttonTapped() {
        guard let windowScene = view.window?.windowScene else { return }
        let onboardingVC = OnboardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        if let window = windowScene.windows.first {
            // Создаем анимацию перехода
            let transition = CATransition()
            transition.type = .push
            transition.subtype = .fromRight
            transition.duration = 0.3
            window.layer.add(transition, forKey: kCATransition)
            
            // Установить OnboardingViewController как rootViewController
            window.rootViewController = onboardingVC
            window.makeKeyAndVisible()
            
            // Установка первой страницы OnboardingViewController
            onboardingVC.setViewControllers([onboardingVC.pages[0]], direction: .forward, animated: true, completion: nil)
        }
    }
}
