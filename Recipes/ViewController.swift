//
//  ViewController.swift
//  Recipes
//
//  Created by WWDC on 01.07.2024.
//

import UIKit

class ViewController: UIViewController {
    let cell = TrendingCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
    }

    private func setupCell() {
        view.addSubview(cell)
        cell.backgroundColor = .red
        cell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cell.widthAnchor.constraint(equalToConstant: 300),
            cell.heightAnchor.constraint(equalToConstant: 150)
        
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
