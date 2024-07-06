//
//  PopularCell.swift
//  Recipes
//
//  Created by Andrey Zavershinskiy on 03.07.2024.
//

import UIKit

final class PopularCell: UICollectionViewCell {

	private lazy var cellView = UIView()
	private lazy var backView = UIView()
	private lazy var dishImage = UIImageView()
	private lazy var dishTitleLabel = UILabel()
	private lazy var timeLabel = UILabel()
	private lazy var durationLabel = UILabel()

	private lazy var bookmark = BookmarkView()
	private var bookmarkState = true // test

	// MARK: - Cell initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Reusing cell
	override func prepareForReuse() {
		super.prepareForReuse()
		dishImage.image = nil
		dishTitleLabel.text = nil
		durationLabel.text = nil
	}

	// MARK: - Updating cell from Model
//	func updateCell(model: Recipe) {
//		self.dishImage = model.???
//		self.dishTitleLabel = model.???
//		self.durationLabel = model.???
//		DispatchQueue.global().async {
//			if let url = URL(string: model.???.url ),
//			   let data = try? Data(contentsOf: url) {
//				DispatchQueue.main.async {
//					self.dishImage.image = UIImage(data: data)
//				}
//			}
//		}
//	}

}

private extension PopularCell {

	// MARK: - Setup UI
	func setupView() {
		cellView.backgroundColor = .clear

		backView.backgroundColor = #colorLiteral(red: 0.9562537074, green: 0.9562535882, blue: 0.9562537074, alpha: 1)
		backView.layer.cornerRadius = 12
		backView.layer.masksToBounds = true

		dishImage.backgroundColor = .green // test
		dishImage.layer.cornerRadius = 55
		dishImage.layer.masksToBounds = true

		dishTitleLabel.textAlignment = .center
		dishTitleLabel.text = "Chicken and Vegetable wrap" // test text
		dishTitleLabel.font = .custom(font: .bold, size: 14)
		dishTitleLabel.numberOfLines = 2

		durationLabel.textAlignment = .left
		durationLabel.text = "5 Mins" // test text
		durationLabel.font = .custom(font: .bold, size: 12)

		timeLabel.textAlignment = .left
		timeLabel.text = "Time"
		timeLabel.textColor = #colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1)
		timeLabel.font = .custom(font: .regular, size: 12)

		bookmark.configure(with: bookmarkState)

		contentView.addSubview(cellView)
		cellView.addSubview(backView)
		cellView.addSubview(dishImage)
		cellView.addSubview(dishTitleLabel)
		cellView.addSubview(durationLabel)
		cellView.addSubview(timeLabel)
		cellView.addSubview(bookmark)

		setupConstraints()
	}

	// MARK: - Constraints
	func setupConstraints() {
		cellView.translatesAutoresizingMaskIntoConstraints = false
		backView.translatesAutoresizingMaskIntoConstraints = false
		dishImage.translatesAutoresizingMaskIntoConstraints = false
		dishTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		timeLabel.translatesAutoresizingMaskIntoConstraints = false
		durationLabel.translatesAutoresizingMaskIntoConstraints = false
		bookmark.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			cellView.heightAnchor.constraint(equalToConstant: 231),
			cellView.widthAnchor.constraint(equalToConstant: 150),
			cellView.centerXAnchor.constraint(equalTo: centerXAnchor),
			cellView.centerYAnchor.constraint(equalTo: centerYAnchor),

			dishImage.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
			dishImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 2),
			dishImage.heightAnchor.constraint(equalToConstant: 110),
			dishImage.widthAnchor.constraint(equalTo: dishImage.heightAnchor),

			backView.topAnchor.constraint(equalTo: dishImage.centerYAnchor),
			backView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
			backView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
			backView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),

			dishTitleLabel.topAnchor.constraint(equalTo: dishImage.bottomAnchor, constant: 12),
			dishTitleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
			dishTitleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),

			durationLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -11),
			durationLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),

			timeLabel.bottomAnchor.constraint(equalTo: durationLabel.topAnchor, constant: -4),
			timeLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),

			bookmark.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -11),
			bookmark.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
		])
	}
}

//MARK: - Preview
import SwiftUI

struct PopularCellProvider: PreviewProvider {
	static var previews: some View {
		ContainerView().ignoresSafeArea()
	}
	struct ContainerView: UIViewRepresentable {
		let view = PopularCell()

		func makeUIView(context: Context) -> some UIView {
			return view
		}
		func updateUIView(_ uiView: UIViewType, context: Context) { }
	}
}
