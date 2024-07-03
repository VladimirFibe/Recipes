//
//  ViewController.swift
//  Recipes
//
//  Created by WWDC on 01.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var recentCell = RecentCell()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCell()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupCell() {
        view.addSubview(recentCell)
        recentCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentCell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recentCell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            recentCell.widthAnchor.constraint(equalToConstant: 200),
            recentCell.heightAnchor.constraint(equalToConstant: 300)
            
        ])
    }
}

