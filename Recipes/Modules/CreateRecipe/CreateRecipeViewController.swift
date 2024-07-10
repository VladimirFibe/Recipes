//
//  CreateRecipeViewController.swift
//  Recipes
//
//  Created by Валентина Попова on 10.07.2024.
//

import UIKit

class CreateRecipeViewController: UIViewController {
    
    // MARK: - UI Elements
    private let recipeImageView = UIImageView()
    private let pencilButton = UIButton(type: .system)
    private let recipeTitleTextField = UITextField()
    private let servesLabel = UILabel()
    private let servesPickerView = UIPickerView()
    private let cookTimeLabel = UILabel()
    private let cookTimePickerView = UIPickerView()
    private let ingredientsLabel = UILabel()
    private let createRecipeButton = UIButton(type: .system)
    
    private var servesData: [Int] = Array(1...10)
    private var cookTimeData: [Int] = Array(stride(from: 10, through: 180, by: 10))
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Create Recipe"
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        configureUIElements()
        
        servesPickerView.dataSource = self
        servesPickerView.delegate = self
        cookTimePickerView.dataSource = self
        cookTimePickerView.delegate = self
        
        pencilButton.addTarget(self, action: #selector(pencilButtonTapped), for: .touchUpInside)
        
        view.addSubview(recipeImageView)
        view.addSubview(pencilButton)
        view.addSubview(recipeTitleTextField)
        view.addSubview(servesLabel)
        view.addSubview(servesPickerView)
        view.addSubview(cookTimeLabel)
        view.addSubview(cookTimePickerView)
        view.addSubview(ingredientsLabel)
        view.addSubview(createRecipeButton)
    }
    
    private func configureUIElements() {
        recipeImageView.image = UIImage(named: "image4")
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.layer.cornerRadius = 15
        recipeImageView.layer.masksToBounds = true
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let pencilImage = UIImage(named: "pencil")?.withRenderingMode(.alwaysOriginal) {
            pencilButton.setImage(pencilImage, for: .normal)
        }
        pencilButton.backgroundColor = .white
        pencilButton.layer.cornerRadius = 16
        pencilButton.layer.masksToBounds = true
        pencilButton.translatesAutoresizingMaskIntoConstraints = false
        
        recipeTitleTextField.placeholder = "Named recipe"
        recipeTitleTextField.borderStyle = .roundedRect
        recipeTitleTextField.layer.borderColor = UIColor(red: 226/255, green: 62/255, blue: 62/255, alpha: 1).cgColor
        recipeTitleTextField.layer.borderWidth = 1.0
        recipeTitleTextField.layer.cornerRadius = 10
        recipeTitleTextField.layer.masksToBounds = true
        recipeTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        servesLabel.text = "Serves"
        servesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        servesPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        cookTimeLabel.text = "Cook time"
        cookTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cookTimePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        createRecipeButton.setTitle("Create recipe", for: .normal)
        createRecipeButton.backgroundColor = UIColor(red: 226/255, green: 62/255, blue: 62/255, alpha: 1)
        createRecipeButton.setTitleColor(.white, for: .normal)
        createRecipeButton.layer.cornerRadius = 10
        createRecipeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            pencilButton.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 10),
            pencilButton.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -10),
            pencilButton.widthAnchor.constraint(equalToConstant: 32),
            pencilButton.heightAnchor.constraint(equalToConstant: 32),
            
            recipeTitleTextField.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20),
            recipeTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recipeTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recipeTitleTextField.heightAnchor.constraint(equalToConstant: 44),
            
            servesLabel.topAnchor.constraint(equalTo: recipeTitleTextField.bottomAnchor, constant: 20),
            servesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            servesPickerView.topAnchor.constraint(equalTo: servesLabel.bottomAnchor, constant: 10),
            servesPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            servesPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            servesPickerView.heightAnchor.constraint(equalToConstant: 100),
            
            cookTimeLabel.topAnchor.constraint(equalTo: servesPickerView.bottomAnchor, constant: 20),
            cookTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            cookTimePickerView.topAnchor.constraint(equalTo: cookTimeLabel.bottomAnchor, constant: 10),
            cookTimePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cookTimePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cookTimePickerView.heightAnchor.constraint(equalToConstant: 100),
            
            ingredientsLabel.topAnchor.constraint(equalTo: cookTimePickerView.bottomAnchor, constant: 20),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            createRecipeButton.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 20),
            createRecipeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createRecipeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createRecipeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: - Actions
    @objc private func pencilButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension CreateRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            recipeImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension CreateRecipeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == servesPickerView {
            return servesData.count
        } else {
            return cookTimeData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == servesPickerView {
            return "\(servesData[row])"
        } else {
            return "\(cookTimeData[row]) min"
        }
    }
}
