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

		addSubviews()
		setupPictureView()
	}
}

// MARK: - Setting UI

private extension SearchResultCell {
	
	func addSubviews() {
		contentView.addSubview(pictureView)
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
			pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}

@available(iOS 17.0, *)
#Preview {
	SearchResultViewController()
}
