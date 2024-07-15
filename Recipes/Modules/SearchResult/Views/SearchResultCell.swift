//
//  SearchResultCell.swift
//  Recipes
//
//  Created by Дмитрий Лубов on 08.07.2024.
//

import UIKit

final class SearchResultCell: UICollectionViewCell {

	static let reusableIdentifier = String(describing: type(of: SearchResultCell.self))

	// MARK: - Private properties

	private lazy var imageView = makeImageView()
	private lazy var descriptionRecipeLabel = makeLabel()
	private let starLabel = RatingLabel()

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
		imageView.kf.setImage(with: URL(string: recipe.image ?? ""))
		starLabel.configure(with: recipe.stars)

		let title = [NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 16)!]
		let info = "\(recipe.numberOfIngredients) Ingredients | \(recipe.readyInMinutes) min"
		let descriptionRecipe = NSMutableAttributedString(string: "\(recipe.title)\n", attributes: title)
		descriptionRecipe.append(NSAttributedString(string: info))
		
		descriptionRecipeLabel.attributedText = descriptionRecipe
	}
}

// MARK: - Setup UI

private extension SearchResultCell {
	
	func setupUI() {
		translatesAutoresizingMaskIntoConstraints = false

		addSubviews()
		setupStarLabel()
	}

	func makeLabel() -> UILabel {
		let element = UILabel()

		element.font = UIFont(name: "Poppins-Regular", size: 12)
		element.textColor = .white
		element.numberOfLines = 0
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	func makeImageView() -> UIImageView {
		let element = UIImageView()

		element.contentMode = .scaleAspectFill
		element.layer.cornerRadius = 10
		element.clipsToBounds = true
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}
}

// MARK: - Setting UI

private extension SearchResultCell {
	
	func addSubviews() {
		contentView.addSubview(imageView)

		imageView.addSubview(starLabel)
		imageView.addSubview(descriptionRecipeLabel)
	}

	func setupStarLabel() {
		starLabel.translatesAutoresizingMaskIntoConstraints = false
	}
}

// MARK: - Layout UI

private extension SearchResultCell {
	
	func layout() {
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			starLabel.topAnchor.constraint(equalTo: imageView.layoutMarginsGuide.topAnchor),
			starLabel.leadingAnchor.constraint(equalTo: imageView.layoutMarginsGuide.leadingAnchor),

			descriptionRecipeLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15),
			descriptionRecipeLabel.trailingAnchor.constraint(equalTo: imageView.layoutMarginsGuide.trailingAnchor),
			descriptionRecipeLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -15)
		])
	}
}

@available(iOS 17.0, *)
#Preview {
	SearchResultViewController()
}
