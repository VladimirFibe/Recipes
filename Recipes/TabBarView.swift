//
//  TabBar.swift
//  Recipes
//
//  Created by Дмитрий Лубов on 01.07.2024.
//

import UIKit

/// Протокол делегата
protocol ITabBarViewDelegate: AnyObject {
	
	/// Добавить
	func add()
	/// Переход на экран по индексу
	/// - Parameter index: индекс
	func changeScreen(by index: Int)
}

final class TabBarView: UIView {

	// MARK: - Dependencies

	private weak var delegate: ITabBarViewDelegate?

	// MARK: - Private properties

	private lazy var shapeLayer = makeShapeLayer()
	private lazy var plusButton = makeButton()

	private lazy var buttonStack = makeStackView()
	private let homeButton = TabBarItem.Icon.home.item
	private let bookmarkButton = TabBarItem.Icon.bookmark.item
	private let notificationButton = TabBarItem.Icon.notification.item
	private let profileButton = TabBarItem.Icon.profile.item

	private var selectedButton: TabBarItem?

	// MARK: - Initialization

	init(delegate: ITabBarViewDelegate) {
		super.init(frame: .zero)
		self.delegate = delegate
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

	// MARK: - Private methods

	private func didSelected(item: TabBarItem) {
		selectedButton?.unselected()
		item.selected()
		selectedButton = item
	}
}

// MARK: - Actions

private extension TabBarView {

	@objc
	func plusButtonTapped(_ sender: UIButton) {
		delegate?.add()
	}

	@objc
	func tabBarItemTapped(_ sender: TabBarItem) {
		delegate?.changeScreen(by: sender.tag)
		didSelected(item: sender)
	}
}

// MARK: - Setup UI

private extension TabBarView {
	
	func setupUI() {
		layer.insertSublayer(shapeLayer, at: 0)
		translatesAutoresizingMaskIntoConstraints = false

		delegate?.changeScreen(by: homeButton.tag)
		didSelected(item: homeButton)

		addSubviews()
		addActions()
	}

	func makeShapeLayer() -> CAShapeLayer {
		let layer = CAShapeLayer()

		layer.fillColor = UIColor.white.cgColor
		layer.shadowColor = UIColor(red: 0.42, green: 0.42, blue: 0.42, alpha: 0.08).cgColor
		layer.shadowOpacity = 0.8
		layer.shadowOffset = CGSize(width: 0, height: -1)
		
		return layer
	}

	func makeButton() -> UIButton {
		let element = UIButton()

		element.configuration = .filled()
		element.configuration?.baseBackgroundColor = UIColor(red: 0.89, green: 0.24, blue: 0.24, alpha: 1.00)
		element.configuration?.cornerStyle = .capsule
		element.configuration?.image = UIImage(named: "plus")?.withRenderingMode(.alwaysTemplate)
		element.configuration?.baseForegroundColor = .black
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	func makeStackView() -> UIStackView {
		let element = UIStackView()

		element.distribution = .fillEqually
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}
}

// MARK: - Setting UI

private extension TabBarView {
	
	func addSubviews() {
		addSubview(plusButton)
		addSubview(buttonStack)

		buttonStack.addArrangedSubview(homeButton)
		buttonStack.addArrangedSubview(bookmarkButton)
		buttonStack.addArrangedSubview(UIView())
		buttonStack.addArrangedSubview(notificationButton)
		buttonStack.addArrangedSubview(profileButton)
	}

	func addActions() {
		plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
		homeButton.addTarget(self, action: #selector(tabBarItemTapped), for: .touchUpInside)
		bookmarkButton.addTarget(self, action: #selector(tabBarItemTapped), for: .touchUpInside)
		notificationButton.addTarget(self, action: #selector(tabBarItemTapped), for: .touchUpInside)
		profileButton.addTarget(self, action: #selector(tabBarItemTapped), for: .touchUpInside)
	}
}

// MARK: - Layout UI

private extension TabBarView {
	
	func layout() {
		setupShapeLayerPath()

		NSLayoutConstraint.activate([
			plusButton.topAnchor.constraint(equalTo: topAnchor),
			plusButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			plusButton.widthAnchor.constraint(equalToConstant: 48),
			plusButton.heightAnchor.constraint(equalToConstant: 48),

			buttonStack.topAnchor.constraint(equalTo: topAnchor, constant: 30),
			buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor),
			buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor),
			buttonStack.heightAnchor.constraint(equalToConstant: 40),
		])
	}

	func setupShapeLayerPath() {
		let path = UIBezierPath()
		
		let centerWidth = frame.width / 2
		let height = frame.height
		
		path.move(to: CGPoint(x: 0, y: 14))
		path.addLine(to: CGPoint(x: centerWidth - 58, y: 14))
		path.addCurve(
			to: CGPoint(x: centerWidth, y: 58),
			controlPoint1: CGPoint(x: centerWidth - 28, y: 14),
			controlPoint2: CGPoint(x: centerWidth - 38, y: 58)
		)
		path.addCurve(
			to: CGPoint(x: centerWidth + 58, y: 14),
			controlPoint1: CGPoint(x: centerWidth + 38, y: 58),
			controlPoint2: CGPoint(x: centerWidth + 28, y: 14)
		)
		path.addLine(to: CGPoint(x: centerWidth * 2, y: 14))
		path.addLine(to: CGPoint(x: centerWidth * 2, y: height))
		path.addLine(to: CGPoint(x: 0, y: height))
		path.close()

		shapeLayer.path = path.cgPath
	}
}

@available(iOS 17.0, *)
#Preview {
	ViewController()
}
