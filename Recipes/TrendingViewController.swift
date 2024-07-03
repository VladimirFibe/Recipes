//
//  TrandingViewController.swift
//  Recipes
//
//  Created by Валентина Попова on 02.07.2024.
//

import UIKit

class TrendingViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RecipesCell.self, forCellReuseIdentifier: RecipesCell.identifier)
        navigationItem.title = "Trending now"
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipesCell.identifier, for: indexPath) as? RecipesCell else { fatalError() }


        return cell
    }
}
