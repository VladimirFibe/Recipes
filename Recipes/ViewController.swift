import UIKit

class ViewController: UIViewController {
    let cell = RecentCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
    }

    private func setupCell() {
        view.addSubview(cell)
        cell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cell.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
