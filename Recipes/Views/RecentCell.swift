//
//  RecentCell.swift
//  Recipes
//
//  Created by Ольга Чушева on 01.07.2024.
//

import UIKit
import Kingfisher

final class RecentCell: UICollectionViewCell {
    static let identifier = "RecentCell"
    private lazy var cellView: UIView = {
        let cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = .white
        cellView.layer.masksToBounds = true
        return cellView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .green
        imageView.image = UIImage(named: "tost")
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.minimumScaleFactor = 12
        nameLabel.numberOfLines = 2
        nameLabel.text = "Kelewele Ghanian Recipe"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.font = .systemFont(ofSize: 10, weight: .light)
        userNameLabel.textColor = .gray
        userNameLabel.text = "By Zeelicious Foods"
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return userNameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        setupLayoutPayView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with recipe: Recipe) {
        imageView.kf.setImage(with: URL(string: recipe.image))
        nameLabel.text = recipe.title
        if let sourceName = recipe.sourceName {
            userNameLabel.text = "By \(sourceName)"
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(cellView)
        self.clipsToBounds = true
        cellView.addSubview(imageView)
        cellView.addSubview(nameLabel)
        cellView.addSubview(userNameLabel)
    }
    
    private func setupLayoutPayView() {
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 124),
            imageView.widthAnchor.constraint(equalToConstant: 124),
            imageView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: cellView.topAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            
            userNameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 3),
            userNameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5)
        ])
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cellView.heightAnchor.constraint(equalToConstant: 190),
            cellView.widthAnchor.constraint(equalToConstant: 124),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
