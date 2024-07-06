//
//  TrandingViewController.swift
//  Recipes
//
//  Created by Валентина Попова on 02.07.2024.
//

import UIKit

class TrendingViewController: UITableViewController {
    private let store = TrendingStore()
    private var bag = Bag()
    private var recipes: [Recipe] = [] { didSet { tableView.reloadData()}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RecipesCell.self, forCellReuseIdentifier: RecipesCell.identifier)
        navigationItem.title = "Trending now"
        store.sendAction(.get)
        setupObservers()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipesCell.identifier, for: indexPath) as? RecipesCell 
        else { fatalError() }
        cell.configure(with: recipes[indexPath.row])
        return cell
    }
}

extension TrendingViewController {
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .done(let recipes):
                    self.recipes = recipes
                }
            }.store(in: &bag)
    }
}
