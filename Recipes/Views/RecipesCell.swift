//
//  RecipesCell.swift
//  Recipes
//
//  Created by Vladimir on 03.07.2024.
//

import UIKit

final class RecipesCell: UITableViewCell {
    static let identifier = "RecentCell"
    private let pictureView = PictureView()
    private let footerView = TrendingFooterView()
    private let timeLabel = DurationLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPictureView()
        setupFooterView()
        setupTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with recipe: Recipe) {
        footerView.configure(with: recipe)
        pictureView.configure(with: recipe)
        timeLabel.configure(with: recipe.time)
    }
    
    private func setupPictureView() {
        contentView.addSubview(pictureView)
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pictureView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func setupFooterView() {
        contentView.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: pictureView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: pictureView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 258)
        ])
    }
    
    private func setupTimeLabel() {
        pictureView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: -8),
            timeLabel.bottomAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: -8)
        ])
    }
}
