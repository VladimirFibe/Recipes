//
//  DiscoverViewController.swift
//  Recipes
//
//  Created by Vladimir on 06.07.2024.
//

import UIKit

final class DiscoverViewController: UITableViewController {
    private var recipes = Bundle.main.decode([Recipe].self, from: "Recipes.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RecipesCell.self, forCellReuseIdentifier: RecipesCell.identifier)
        navigationItem.title = "Saved recipes"
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
