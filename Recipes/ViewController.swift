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
<<<<<<< HEAD
            cell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cell.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
=======
            creatorCell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            creatorCell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            creatorCell.widthAnchor.constraint(equalToConstant: 120),
            creatorCell.heightAnchor.constraint(equalToConstant: 150)
>>>>>>> 74a119fe50e04d8d5d9bd42c82d2499c909e10b7
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
