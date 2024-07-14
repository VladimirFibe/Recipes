//
//  TabBarViewController.swift
//  Recipes
//
//  Created by Дмитрий Лубов on 03.07.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {

	// MARK: - Private properties

	private lazy var tabBarView = TabBarView(delegate: self)

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupViewControllers(
            UINavigationController(rootViewController: HomeViewController()),
			UINavigationController(rootViewController: DiscoverViewController()),
            UINavigationController(rootViewController: TrendingViewController()),
            UINavigationController(rootViewController: DiscoverViewController())
		)
	}

	override func viewDidLayoutSubviews() {
		layout()
	}
}

// MARK: - ITabBarViewDelegate

extension TabBarViewController: ITabBarViewDelegate {

	/// Добавить новый рецепт
	func add() {
		print("\(String(describing: type(of: self))).\(#function)")
	}

	/// Переход на экран по индексу
	/// - Parameter index: индекс
	func changeScreen(by index: Int) {
		selectedIndex = index
	}
}

// MARK: - Setup UI

private extension TabBarViewController {

	func setupUI() {
		tabBar.isHidden = true

		addSubviews()
	}

	func setupViewControllers(_ viewControllers: UIViewController...) {
		setViewControllers(viewControllers, animated: true)
	}
}

// MARK: - Setting UI

private extension TabBarViewController {

	func addSubviews() {
		view.addSubview(tabBarView)
	}
}

// MARK: - Layout UI

private extension TabBarViewController {

	func layout() {
		NSLayoutConstraint.activate([
			tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tabBarView.heightAnchor.constraint(equalToConstant: 120),
			tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

//@available(iOS 17.0, *)
//#Preview {
//	TabBarViewController()
//}
