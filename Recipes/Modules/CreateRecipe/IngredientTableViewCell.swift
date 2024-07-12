//
//  IngredientTableViewCell.swift
//  Recipes
//
//  Created by Валентина Попова on 12.07.2024.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    static let identifier = "IngredientTableViewCell"
    
    let ingredientNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Item name"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    let quantityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Quantity"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(ingredientNameTextField)
        contentView.addSubview(quantityTextField)
        contentView.addSubview(actionButton)
        
        ingredientNameTextField.translatesAutoresizingMaskIntoConstraints = false
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ingredientNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ingredientNameTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ingredientNameTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            ingredientNameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            quantityTextField.leadingAnchor.constraint(equalTo: ingredientNameTextField.trailingAnchor, constant: 10),
            quantityTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quantityTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            quantityTextField.heightAnchor.constraint(equalToConstant: 44),
            
            actionButton.leadingAnchor.constraint(equalTo: quantityTextField.trailingAnchor, constant: 10),
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with ingredient: Ingredient, isLast: Bool) {
        ingredientNameTextField.text = ingredient.name
        quantityTextField.text = ingredient.quantity
        let buttonImage = isLast ? UIImage(named: "plusIngredient") : UIImage(named: "minus")
        actionButton.setImage(buttonImage, for: .normal)
    }
}
