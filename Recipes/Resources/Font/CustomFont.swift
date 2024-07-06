//
//  CustomFont.swift
//  Recipes
//
//  Created by Andrey Zavershinskiy on 03.07.2024.
//

import UIKit

enum CustomFont: String {
	case regular = "Poppins-Regular"
	case bold = "Poppins-Bold"
}

extension UIFont {
	///Пример : label.font = .custom(font: .bold, size: 20)
	static func custom(font: CustomFont, size: CGFloat) -> UIFont {
		guard let customFont = UIFont(name: font.rawValue, size: size) else {
			fatalError(
				"Не удалось загрузить \(font.rawValue) шрифт."
			)
		}
		return customFont
	}
}
