import UIKit

class ContentViewController: UIViewController {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let actionButton = UIButton()
    
    var imageFile: String
    var titleText: String
    var subtitleText: String
    var buttonText: String
    var isFirstPage: Bool
    
    init(imageName: String, titleText: String, subtitleText: String, buttonText: String, isFirstPage: Bool) {
        self.imageFile = imageName
        self.titleText = titleText
        self.subtitleText = subtitleText
        self.buttonText = buttonText
        self.isFirstPage = isFirstPage
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageFile)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
        actionButton.setTitle(buttonText, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ContentViewController {
    
    func style() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textColor = .white
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = UIColor(red: 226/255, green: 62/255, blue: 62/255, alpha: 1)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        
        if isFirstPage {
            actionButton.layer.cornerRadius = 10
        } else {
            actionButton.layer.cornerRadius = 25
        }
    }
    
    func layout() {
        view.addSubview(imageView)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(actionButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: subtitleLabel.trailingAnchor, multiplier: 2),
            
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.widthAnchor.constraint(equalToConstant: isFirstPage ? 200 : 250)
        ])
    }
    
    @objc func buttonTapped() {
        if buttonText == "Start Cooking" {
            print("Start Cooking tapped")
        } else {
            if let parentVC = self.parent as? OnboardingViewController {
                parentVC.goToNextPage()
            }
        }
    }
}
