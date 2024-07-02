import UIKit

class ViewController: UIViewController {


    let creatorCell = CreatorCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCellLayout()
        configureCell()
    }

    private func configureCellLayout() {
        view.addSubview(creatorCell)
        creatorCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            creatorCell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            creatorCell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            creatorCell.widthAnchor.constraint(equalToConstant: 120),
            creatorCell.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureCell() {
        let avatarImage = UIImage(named: "chef")!
        let name = "Ify's Kitchen"
        creatorCell.configure(with: avatarImage, name: name)
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
