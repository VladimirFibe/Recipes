//
//  TabBarItem.swift
//  Recipes
//
//  Created by Дмитрий Лубов on 02.07.2024.
//

import UIKit

final class TabBarItem: UIButton {

	private let selectedImage: UIImage
	private let unselectedImage: UIImage
	
	private init(icon: TabBarItem.Icon) {
		self.selectedImage = icon.redImage
		self.unselectedImage = icon.grayImage

		super.init(frame: .zero)

		configuration = .plain()
		tag = icon.tag
		translatesAutoresizingMaskIntoConstraints = false

		unselected()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func selected() {
		configuration?.image = selectedImage
	}

	func unselected() {
		configuration?.image = unselectedImage
	}
}

extension TabBarItem {

	enum Icon {
		case home
		case bookmark
		case notification
		case profile

		var redImage: UIImage {
			switch self {
			case .home:
				return UIImage(named: "red-fill-home")!
			case .bookmark:
                return UIImage(named: "red-fill-bookmark")!
			case .notification:
                return UIImage(named: "red-fill-notification")!
			case .profile:
                return UIImage(named: "red-fill-profile")!
			}
		}

		var grayImage: UIImage {
			switch self {
			case .home:
                return UIImage(named: "home")!
			case .bookmark:
                return UIImage(named: "bookmark")!
			case .notification:
                return UIImage(named: "notification")!
			case .profile:
                return UIImage(named: "profile")!
			}
		}

		var tag: Int {
			switch self {
			case .home:
                return 0
			case .bookmark:
                return 1
			case .notification:
                return 2
			case .profile:
                return 3
			}
		}

		var item: TabBarItem {
			TabBarItem(icon: self)
		}
	}
}
