//
//  IngredientsCell.swift
//  Recipes
//
//  Created by Ольга Чушева on 07.07.2024.
//

import Foundation
import UIKit

class IngredientsCell: UITableViewCell {
    static let identifire = "IngredientsCell"
    lazy var ingredientsByID = 1003464
    
    private var ingredientsLoader = IngredientsLoader()
    private var ingredient: [Ingredient] = []

    
    private lazy var ingredientsView: UIView = {
        let ingredientsView = UIView()
        ingredientsView.backgroundColor = .systemGray6
        ingredientsView.layer.cornerRadius = 12
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsView
    }()
    
    private lazy var ingredientsImage: UIImageView = {
        let ingredientsImage = UIImageView()
        ingredientsImage.image = UIImage()
		ingredientsImage.backgroundColor = .white
		ingredientsImage.layer.cornerRadius = 5
		ingredientsImage.clipsToBounds = true
        ingredientsImage.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsImage
    }()
    
    private lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Cucumber"
        ingredientsLabel.textColor = .black
        ingredientsLabel.font = .systemFont(ofSize: 16, weight: .bold)
		ingredientsLabel.numberOfLines = 0
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    private lazy var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.text = "100g"
        amountLabel.textColor = .gray
        amountLabel.font = .systemFont(ofSize: 14)
		amountLabel.numberOfLines = 2
		amountLabel.textAlignment = .right
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        return amountLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
//        loadData()
        addSubviews()
        setupLayout()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        ingredientsLoader.loadIngredients { [weak self] result in
                 guard let self = self else { return }
                 switch result {
                 case .success(let ingredient):
                     self.ingredient = ingredient
                    
                 case .failure(_):
                    print("Error")
                 }
             }
     }
	
	func configure(with ingredient: Ingredient) {
		if let sourceImage = ingredient.sourceImage {
			ingredientsImage.kf.setImage(with: URL(string: sourceImage))
		}
		ingredientsLabel.text = ingredient.name
		amountLabel.text = "\(ingredient.amount) \(ingredient.unit)"
	}
    
    private func addSubviews() {
        contentView.addSubview(ingredientsView)
        ingredientsView.addSubview(ingredientsImage)
        ingredientsView.addSubview(ingredientsLabel)
        ingredientsView.addSubview(amountLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            ingredientsView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ingredientsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ingredientsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ingredientsView.heightAnchor.constraint(equalToConstant: 76),
            
            ingredientsImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ingredientsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientsImage.heightAnchor.constraint(equalToConstant: 52),
            ingredientsImage.widthAnchor.constraint(equalToConstant: 52),
            
            ingredientsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 84),
			ingredientsLabel.widthAnchor.constraint(equalToConstant: 190),
            
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			amountLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}

//@available(iOS 17.0, *)
//#Preview {
//	UINavigationController(rootViewController: RecipeDetailViewController())
//}
