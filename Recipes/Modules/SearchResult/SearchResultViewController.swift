//
//  SearchResultViewController.swift
//  Recipes
//
//  Created by Дмитрий Лубов on 08.07.2024.
//

import UIKit

final class SearchResultViewController: UIViewController {
	
	private var recipes = Bundle.main.decode([Recipe].self, from: "Recipes.json")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let cell = SearchResultCell()
		print(SearchResultCell.reusableIdentifier)
		cell.configure(with: recipes[0])
		view.addSubview(cell)
		NSLayoutConstraint.activate([
			cell.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			cell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			cell.widthAnchor.constraint(equalToConstant: 343),
			cell.heightAnchor.constraint(equalToConstant: 200)
		])
	}
}

@available(iOS 17.0, *)
#Preview {
	SearchResultViewController()
}
