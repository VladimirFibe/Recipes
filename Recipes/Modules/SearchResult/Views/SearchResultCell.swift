//
//  SearchResultCell.swift
//  Recipes
//
//  Created by Дмитрий Лубов on 08.07.2024.
//

import UIKit

final class SearchResultCell: UICollectionViewCell {
	
	static let reusableIdentifier = String(describing: type(of: SearchResultCell.self))
	
	// MARK: - Outlets
	
	// MARK: - Public properties
	
	// MARK: - Dependencies
	
	// MARK: - Private properties

	private let pictureView = PictureView()
	private lazy var descriptionRecipeLabel = makeLabel()

	// MARK: - Initialization

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}
	
	// MARK: - Public methods

	func configure(with recipe: Recipe) {
		pictureView.configure(with: recipe)
		
		let title = [NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 16)!]
		let info = "\(recipe.numberOfIngredients) Ingredients | \(recipe.readyInMinutes) min"
		let descriptionRecipe = NSMutableAttributedString(string: "\(recipe.title)\n", attributes: title)
		descriptionRecipe.append(NSAttributedString(string: info))
		
		descriptionRecipeLabel.attributedText = descriptionRecipe
	}

	// MARK: - Private methods
}

// MARK: - Actions

private extension SearchResultCell {
	
}

// MARK: - Setup UI

private extension SearchResultCell {
	
	func setupUI() {
		layer.cornerRadius = 10
		translatesAutoresizingMaskIntoConstraints = false
		descriptionRecipeLabel.text = "descriptionRecipeLabel"

		addSubviews()
		setupPictureView()
	}

	func makeLabel() -> UILabel {
		let element = UILabel()

		element.font = UIFont(name: "Poppins-Regular", size: 12)
		element.textColor = .white
		element.numberOfLines = 0
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}
}

// MARK: - Setting UI

private extension SearchResultCell {
	
	func addSubviews() {
		contentView.addSubview(pictureView)
		pictureView.addSubview(descriptionRecipeLabel)
	}

	func setupPictureView() {
		pictureView.translatesAutoresizingMaskIntoConstraints = false
	}
}

// MARK: - Layout UI

private extension SearchResultCell {
	
	func layout() {
		NSLayoutConstraint.activate([
			pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
			pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			descriptionRecipeLabel.leadingAnchor.constraint(equalTo: pictureView.layoutMarginsGuide.leadingAnchor),
			descriptionRecipeLabel.trailingAnchor.constraint(equalTo: pictureView.layoutMarginsGuide.trailingAnchor),
			descriptionRecipeLabel.bottomAnchor.constraint(equalTo: pictureView.layoutMarginsGuide.bottomAnchor),
		])
	}
}

@available(iOS 17.0, *)
#Preview {
	SearchResultViewController()
}
