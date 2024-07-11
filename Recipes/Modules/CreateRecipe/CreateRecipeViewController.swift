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
    
    private let servesContainer = UIView()
    private let servesIconContainer = UIView()
    private let servesIcon = UIImageView()
    private let servesLabel = UILabel()
    private let servesButton = UIButton(type: .system)
    private let servesArrow = UIImageView()
    private let servesPickerView = UIPickerView()
    
    private let cookTimeContainer = UIView()
    private let cookTimeIconContainer = UIView()
    private let cookTimeIcon = UIImageView()
    private let cookTimeLabel = UILabel()
    private let cookTimeButton = UIButton(type: .system)
    private let cookTimeArrow = UIImageView()
    private let cookTimePickerView = UIPickerView()
    
    private let ingredientsLabel = UILabel()
    private let createRecipeButton = UIButton(type: .system)
    
    private var servesData: [Int] = Array(1...10)
    private var cookTimeData: [Int] = Array(stride(from: 10, through: 180, by: 10))
    
    private var servesPickerIsVisible = false
    private var cookTimePickerIsVisible = false
    private var servesPickerViewHeightConstraint: NSLayoutConstraint!
    private var cookTimePickerViewHeightConstraint: NSLayoutConstraint!
    private var cookTimeContainerTopConstraint: NSLayoutConstraint!
    private var ingredientsLabelTopConstraint: NSLayoutConstraint!
    
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
        
        view.addSubview(servesContainer)
        servesContainer.addSubview(servesIconContainer)
        servesContainer.addSubview(servesLabel)
        servesContainer.addSubview(servesButton)
        servesContainer.addSubview(servesArrow)
        servesIconContainer.addSubview(servesIcon)
        view.addSubview(servesPickerView)
        
        view.addSubview(cookTimeContainer)
        cookTimeContainer.addSubview(cookTimeIconContainer)
        cookTimeContainer.addSubview(cookTimeLabel)
        cookTimeContainer.addSubview(cookTimeButton)
        cookTimeContainer.addSubview(cookTimeArrow)
        cookTimeIconContainer.addSubview(cookTimeIcon)
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
        
        recipeTitleTextField.placeholder = "Recipe name"
        recipeTitleTextField.borderStyle = .none
        recipeTitleTextField.layer.borderColor = UIColor(red: 226/255, green: 62/255, blue: 62/255, alpha: 1).cgColor
        recipeTitleTextField.layer.borderWidth = 1.0
        recipeTitleTextField.layer.cornerRadius = 10
        recipeTitleTextField.layer.masksToBounds = true
        recipeTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: recipeTitleTextField.frame.height))
        recipeTitleTextField.leftView = leftPaddingView
        recipeTitleTextField.leftViewMode = .always
        
        servesContainer.backgroundColor = UIColor(white: 0.95, alpha: 1)
        servesContainer.layer.cornerRadius = 10
        servesContainer.translatesAutoresizingMaskIntoConstraints = false
        
        servesIcon.image = UIImage(named: "serves")?.withRenderingMode(.alwaysOriginal)
        servesIcon.translatesAutoresizingMaskIntoConstraints = false
        
        servesIconContainer.backgroundColor = .white
        servesIconContainer.layer.cornerRadius = 10
        servesIconContainer.layer.masksToBounds = true
        servesIconContainer.translatesAutoresizingMaskIntoConstraints = false
        
        servesLabel.text = "Serves"
        servesLabel.font = UIFont.boldSystemFont(ofSize: 17)
        servesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        servesButton.setTitle("03", for: .normal)
        servesButton.setTitleColor(.gray, for: .normal)
        servesButton.translatesAutoresizingMaskIntoConstraints = false
        servesButton.addTarget(self, action: #selector(openServesPicker), for: .touchUpInside)
        
        servesArrow.image = UIImage(systemName: "arrow.forward")
        servesArrow.tintColor = .black
        servesArrow.isUserInteractionEnabled = true
        let servesTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openServesPicker))
        servesArrow.addGestureRecognizer(servesTapGestureRecognizer)
        servesArrow.translatesAutoresizingMaskIntoConstraints = false
        
        servesPickerView.translatesAutoresizingMaskIntoConstraints = false
        servesPickerView.isHidden = true
        
        cookTimeContainer.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cookTimeContainer.layer.cornerRadius = 10
        cookTimeContainer.translatesAutoresizingMaskIntoConstraints = false
        
        cookTimeIcon.image = UIImage(named: "cookTime")?.withRenderingMode(.alwaysOriginal)
        cookTimeIcon.translatesAutoresizingMaskIntoConstraints = false
        
        cookTimeIconContainer.backgroundColor = .white
        cookTimeIconContainer.layer.cornerRadius = 10
        cookTimeIconContainer.layer.masksToBounds = true
        cookTimeIconContainer.translatesAutoresizingMaskIntoConstraints = false
        
        cookTimeLabel.text = "Cook time"
        cookTimeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cookTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cookTimeButton.setTitle("30 min", for: .normal)
        cookTimeButton.setTitleColor(.gray, for: .normal)
        cookTimeButton.translatesAutoresizingMaskIntoConstraints = false
        cookTimeButton.addTarget(self, action: #selector(openCookTimePicker), for: .touchUpInside)
        
        cookTimeArrow.image = UIImage(systemName: "arrow.forward")
        cookTimeArrow.tintColor = .black
        cookTimeArrow.isUserInteractionEnabled = true
        let cookTimeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openCookTimePicker))
        cookTimeArrow.addGestureRecognizer(cookTimeTapGestureRecognizer)
        cookTimeArrow.translatesAutoresizingMaskIntoConstraints = false

        cookTimePickerView.translatesAutoresizingMaskIntoConstraints = false
        cookTimePickerView.isHidden = true
        
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        createRecipeButton.setTitle("Create recipe", for: .normal)
        createRecipeButton.backgroundColor = UIColor(red: 226/255, green: 62/255, blue: 62/255, alpha: 1)
        createRecipeButton.setTitleColor(.white, for: .normal)
        createRecipeButton.layer.cornerRadius = 10
        createRecipeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        servesPickerViewHeightConstraint = servesPickerView.heightAnchor.constraint(equalToConstant: 0)
        cookTimePickerViewHeightConstraint = cookTimePickerView.heightAnchor.constraint(equalToConstant: 0)
        cookTimeContainerTopConstraint = cookTimeContainer.topAnchor.constraint(equalTo: servesPickerView.bottomAnchor, constant: 10)
        ingredientsLabelTopConstraint = ingredientsLabel.topAnchor.constraint(equalTo: cookTimePickerView.bottomAnchor, constant: 20)
        
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
            
            servesContainer.topAnchor.constraint(equalTo: recipeTitleTextField.bottomAnchor, constant: 20),
            servesContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            servesContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            servesContainer.heightAnchor.constraint(equalToConstant: 60),
            
            servesIconContainer.centerYAnchor.constraint(equalTo: servesContainer.centerYAnchor),
            servesIconContainer.leadingAnchor.constraint(equalTo: servesContainer.leadingAnchor, constant: 10),
            servesIconContainer.widthAnchor.constraint(equalToConstant: 32),
            servesIconContainer.heightAnchor.constraint(equalToConstant: 32),
            
            servesIcon.centerYAnchor.constraint(equalTo: servesIconContainer.centerYAnchor),
            servesIcon.centerXAnchor.constraint(equalTo: servesIconContainer.centerXAnchor),
            servesIcon.widthAnchor.constraint(equalToConstant: 16),
            servesIcon.heightAnchor.constraint(equalToConstant: 16),
            
            servesLabel.centerYAnchor.constraint(equalTo: servesContainer.centerYAnchor),
            servesLabel.leadingAnchor.constraint(equalTo: servesIconContainer.trailingAnchor, constant: 15),
            
            servesButton.centerYAnchor.constraint(equalTo: servesContainer.centerYAnchor),
            servesButton.trailingAnchor.constraint(equalTo: servesArrow.leadingAnchor, constant: -10),
            
            servesArrow.centerYAnchor.constraint(equalTo: servesContainer.centerYAnchor),
            servesArrow.trailingAnchor.constraint(equalTo: servesContainer.trailingAnchor, constant: -10),
            servesArrow.widthAnchor.constraint(equalToConstant: 22),
            servesArrow.heightAnchor.constraint(equalToConstant: 22),
            
            servesPickerView.topAnchor.constraint(equalTo: servesContainer.bottomAnchor, constant: 10),
            servesPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            servesPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            servesPickerViewHeightConstraint,
            
            cookTimeContainerTopConstraint,
            cookTimeContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cookTimeContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cookTimeContainer.heightAnchor.constraint(equalToConstant: 60),
            
            cookTimeIconContainer.centerYAnchor.constraint(equalTo: cookTimeContainer.centerYAnchor),
            cookTimeIconContainer.leadingAnchor.constraint(equalTo: cookTimeContainer.leadingAnchor, constant: 10),
            cookTimeIconContainer.widthAnchor.constraint(equalToConstant: 32),
            cookTimeIconContainer.heightAnchor.constraint(equalToConstant: 32),
            
            cookTimeIcon.centerYAnchor.constraint(equalTo: cookTimeIconContainer.centerYAnchor),
            cookTimeIcon.centerXAnchor.constraint(equalTo: cookTimeIconContainer.centerXAnchor),
            cookTimeIcon.widthAnchor.constraint(equalToConstant: 16),
            cookTimeIcon.heightAnchor.constraint(equalToConstant: 16),
            
            cookTimeLabel.centerYAnchor.constraint(equalTo: cookTimeContainer.centerYAnchor),
            cookTimeLabel.leadingAnchor.constraint(equalTo: cookTimeIconContainer.trailingAnchor, constant: 15),
            
            cookTimeButton.centerYAnchor.constraint(equalTo: cookTimeContainer.centerYAnchor),
            cookTimeButton.trailingAnchor.constraint(equalTo: cookTimeArrow.leadingAnchor, constant: -10),
            
            cookTimeArrow.centerYAnchor.constraint(equalTo: cookTimeContainer.centerYAnchor),
            cookTimeArrow.trailingAnchor.constraint(equalTo: cookTimeContainer.trailingAnchor, constant: -10),
            cookTimeArrow.widthAnchor.constraint(equalToConstant: 22),
            cookTimeArrow.heightAnchor.constraint(equalToConstant: 22),
            
            cookTimePickerView.topAnchor.constraint(equalTo: cookTimeContainer.bottomAnchor, constant: 10),
            cookTimePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cookTimePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cookTimePickerViewHeightConstraint,
            
            ingredientsLabelTopConstraint,
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
    
    @objc private func openServesPicker() {
        servesPickerIsVisible.toggle()
        
        servesPickerViewHeightConstraint.constant = servesPickerIsVisible ? 100 : 0
        
        UIView.animate(withDuration: 0.3) {
            self.servesPickerView.isHidden = !self.servesPickerIsVisible
            self.servesPickerView.alpha = self.servesPickerIsVisible ? 1 : 0
            self.cookTimeContainerTopConstraint.constant = self.servesPickerIsVisible ? 110 : 10
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func openCookTimePicker() {
        cookTimePickerIsVisible.toggle()
        
        cookTimePickerViewHeightConstraint.constant = cookTimePickerIsVisible ? 100 : 0
        
        UIView.animate(withDuration: 0.3) {
            self.cookTimePickerView.isHidden = !self.cookTimePickerIsVisible
            self.cookTimePickerView.alpha = self.cookTimePickerIsVisible ? 1 : 0
            self.ingredientsLabelTopConstraint.constant = self.cookTimePickerIsVisible ? 110 : 20
            self.view.layoutIfNeeded()
        }
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == servesPickerView {
            servesButton.setTitle(String(format: "%02d", servesData[row]), for: .normal)
            servesPickerIsVisible = true
            openServesPicker()
        } else if pickerView == cookTimePickerView {
            cookTimeButton.setTitle("\(cookTimeData[row]) min", for: .normal)
            cookTimePickerIsVisible = true
            openCookTimePicker()
        }
    }
}
