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
        tableView.register(RecentCell.self, forCellReuseIdentifier: RecentCell.identifier)
        navigationItem.title = "Trending now"
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier, for: indexPath) as? RecentCell else { fatalError() }


        return cell
    }
}
