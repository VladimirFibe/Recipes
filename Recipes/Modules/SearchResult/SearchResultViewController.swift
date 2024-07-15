//
//  SearchResultViewController.swift
//  Recipes
//
//  Created by Дмитрий Лубов on 08.07.2024.
//

import UIKit

final class SearchResultViewController: UIViewController {

	// MARK: - Private properties

	var recipes = Bundle.main.decode([Recipe].self, from: "Recipes.json") {
		didSet {
			collectionView.reloadData()
		}
	}

	private lazy var collectionView = makeCollectionView()

	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

// MARK: - Collection View Data Source

extension SearchResultViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		recipes.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		let cell = collectionView
			.dequeueReusableCell(withReuseIdentifier: SearchResultCell.reusableIdentifier, for: indexPath)
		guard let cell = cell as? SearchResultCell else { return UICollectionViewCell() }

		cell.configure(with: recipes[indexPath.row])

		return cell
	}
}

// MARK: - Collection View Delegate

extension SearchResultViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let viewController = RecipeDetailViewController(recipe: recipes[indexPath.row])
		navigationController?.pushViewController(viewController, animated: true)
	}
}

// MARK: - Setup UI

private extension SearchResultViewController {
	
	func setupUI() {
		addSubviews()
	}

	func makeFlowLayout() -> UICollectionViewFlowLayout {
		let layout = UICollectionViewFlowLayout()

		layout.itemSize = CGSize(width: 343, height: 200)
		layout.minimumLineSpacing = 20

		return layout
	}

	func makeCollectionView() -> UICollectionView {
		let element = UICollectionView(frame: .zero, collectionViewLayout: makeFlowLayout())

		element.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.reusableIdentifier)
		element.dataSource = self
		element.delegate = self
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}
}

// MARK: - Setting UI

private extension SearchResultViewController {
	
	func addSubviews() {
		view.addSubview(collectionView)
	}
}

// MARK: - Layout UI

private extension SearchResultViewController {
	
	func layout() {
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

//@available(iOS 17.0, *)
//#Preview {
//	UINavigationController(rootViewController: SearchResultViewController())
//}
