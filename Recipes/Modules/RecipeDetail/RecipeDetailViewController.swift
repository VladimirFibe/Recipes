//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Ольга Чушева on 03.07.2024.
//

import Foundation
import UIKit
import WebKit

final class RecipeDetailViewController: UIViewController {
    
    private var recipes = Bundle.main.decode([Recipe].self, from: "Recipes.json")
    
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var nameRecipeLabel: UILabel = {
        let nameRecipeLabel = UILabel()
        nameRecipeLabel.numberOfLines = 2
        nameRecipeLabel.text = recipes[0].title 
        nameRecipeLabel.textColor = .black
        nameRecipeLabel.font = .systemFont(ofSize: 24, weight: .bold)
        nameRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameRecipeLabel
    }()
    
    private lazy var recipeImage: UIImageView = {
        let recipeImage = UIImageView()
        recipeImage.image = UIImage(named: recipes[0].image )
        recipeImage.layer.cornerRadius = 15
        recipeImage.layer.masksToBounds = true
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        return recipeImage
    }()
    
    private lazy var starImage: UIImageView = {
        let starImage = UIImageView()
        starImage.image = UIImage(named: "star12")
        starImage.translatesAutoresizingMaskIntoConstraints = false
        return starImage
    }()
    
    private lazy var raitingLabel: UILabel = {
        let raitingLabel = UILabel()
        raitingLabel.text = "4,5"
        raitingLabel.textColor = .black
        raitingLabel.font = .systemFont(ofSize: 14)
        raitingLabel.translatesAutoresizingMaskIntoConstraints = false
        return raitingLabel
    }()
    
    private lazy var reviewsLabel: UILabel = {
        let reviewsLabel = UILabel()
        reviewsLabel.text = "(300 Reviews)"
        reviewsLabel.textColor = .gray
        reviewsLabel.font = .systemFont(ofSize: 14)
        reviewsLabel.translatesAutoresizingMaskIntoConstraints = false
        return reviewsLabel
    }()
    
    private lazy var instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.text = "Instructions"
        instructionsLabel.textColor = .black
        instructionsLabel.font = .systemFont(ofSize: 22, weight: .bold)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        return instructionsLabel
    }()
    
//    private lazy var instructionsText: UITextView = {
//        let instructionsText = UITextView()
//        instructionsText.text = "Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop. Place chopped eggs in a bowl. Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice. Stir in mayonnaise, green onion, and mustard. Season with paprika, salt, and pepper. Stir and serve on your favorite bread or crackers."
//        instructionsText.textColor = .black
//        instructionsText.font = .systemFont(ofSize: 16)
//        instructionsText.isSelectable = false
//        instructionsText.translatesAutoresizingMaskIntoConstraints = false
//        return instructionsText
//    }()
    
    private lazy var instructionsText: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = false
        
        let html = makeHtml(recipes[0].instructions)
        webView.loadHTMLString(html, baseURL: nil)
      //  webView.contentScaleFactor = 3
        
        return webView
    }()
    
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register( UITableViewCell.self, forCellReuseIdentifier: IngredientsCell.identifire)
        tableView.rowHeight = 76 + 13
        tableView.register(IngredientsCell.self, forCellReuseIdentifier: HeaderIngredientsCell.identifire)
        tableView.separatorColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recipe detail"
        view.backgroundColor = .white
        tableView.register( IngredientsCell.self, forCellReuseIdentifier: IngredientsCell.identifire)
        tableView.register(HeaderIngredientsCell.self, forHeaderFooterViewReuseIdentifier: HeaderIngredientsCell.identifire)
        addSubviews()
        setupLayout()
    }
    
    func makeHtml(_ text: String) -> String {
    """
    <!DOCTYPE html>
    <html><head>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style> body {
    font-family: "Poppins", sans-serif;
    font-weight: 400;
    font-style: normal;
    font-size: 16px;
    line-height: 22px
    } </style>
    </head><body>\(text)</body></html>
    """
    }
    
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameRecipeLabel)
        contentView.addSubview(recipeImage)
        contentView.addSubview(stackView)
        stackView.addSubview(starImage)
        stackView.addSubview(raitingLabel)
        stackView.addSubview(reviewsLabel)
        contentView.addSubview(instructionsLabel)
        contentView.addSubview(instructionsText)
        contentView.addSubview(tableView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            nameRecipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameRecipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            nameRecipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            
            recipeImage.topAnchor.constraint(equalTo: nameRecipeLabel.bottomAnchor, constant: 13),
            recipeImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            recipeImage.heightAnchor.constraint(equalToConstant: 200),

            stackView.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            
            starImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            raitingLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 3),
            reviewsLabel.leadingAnchor.constraint(equalTo: raitingLabel.trailingAnchor, constant: 8),
            
            instructionsLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            instructionsText.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 8),
            instructionsText.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 23),
            instructionsText.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -23),
            instructionsText.heightAnchor.constraint(equalToConstant: 250),
            
            tableView.topAnchor.constraint(equalTo: instructionsText.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 23),
            tableView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -23),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: tableView.rowHeight * 5 + 55)

        ])
            }
    
}

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderIngredientsCell.identifire)
        
        return header
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.identifire, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    

    
    
    
}


