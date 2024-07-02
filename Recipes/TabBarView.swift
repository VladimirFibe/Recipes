//
//  TabBar.swift
//  Recipes
//
//  Created by Дмитрий Лубов on 01.07.2024.
//

import UIKit

final class TabBarView: UIView {
	
	// MARK: - Outlets
	
	// MARK: - Public properties
	
	// MARK: - Dependencies
	
	// MARK: - Private properties

	private lazy var shapeLayer = makeShapeLayer()

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
	
	// MARK: - Private methods
}

// MARK: - Actions

private extension TabBarView {
	
}

// MARK: - Setup UI

private extension TabBarView {
	
	func setupUI() {
		backgroundColor = .black
		layer.insertSublayer(shapeLayer, at: 0)
		translatesAutoresizingMaskIntoConstraints = false

		addSubviews()
	}

	func makeShapeLayer() -> CAShapeLayer {
		let layer = CAShapeLayer()

		layer.fillColor = UIColor.white.cgColor
		layer.shadowColor = UIColor(red: 108 / 255, green: 108 / 255, blue: 108 / 255, alpha: 0.08).cgColor
		layer.shadowOpacity = 0.8
		layer.shadowOffset = CGSize(width: 0, height: -1)
		
		return layer
	}
}

// MARK: - Setting UI

private extension TabBarView {
	
	func addSubviews() {
		
	}
}

// MARK: - Layout UI

private extension TabBarView {
	
	func layout() {
		setupShapeLayerPath()

		NSLayoutConstraint.activate([
			
		])
	}

	func setupShapeLayerPath() {
		let path = UIBezierPath()
		
		let centerWidth = frame.width / 2
		let height = frame.height
		
		path.move(to: CGPoint(x: 0, y: 14))
		path.addLine(to: CGPoint(x: centerWidth - 48, y: 14))
		path.addCurve(
			to: CGPoint(x: centerWidth, y: 58),
			controlPoint1: CGPoint(x: centerWidth - 28, y: 14),
			controlPoint2: CGPoint(x: centerWidth - 38, y: 58)
		)
		path.addCurve(
			to: CGPoint(x: centerWidth + 48, y: 14),
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
