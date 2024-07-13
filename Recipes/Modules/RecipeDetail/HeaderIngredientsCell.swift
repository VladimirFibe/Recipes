//
//  HeaderIngredientsCell.swift
//  Recipes
//
//  Created by Ольга Чушева on 08.07.2024.
//

import Foundation
import UIKit

class HeaderIngredientsCell: UITableViewHeaderFooterView {
    static let identifire = "HeaderIngredientsCell"
    
    private lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.textColor = .black
        ingredientsLabel.font = .systemFont(ofSize: 20, weight: .bold)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    private lazy var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.text = "5 items"
        amountLabel.textColor = .gray
        amountLabel.font = .systemFont(ofSize: 14)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        return amountLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: HeaderIngredientsCell.identifire)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(amountLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
                
            ingredientsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7)
        ])
    }
    
}
