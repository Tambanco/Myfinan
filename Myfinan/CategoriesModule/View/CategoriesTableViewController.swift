//
//  CategoriesTableViewController.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var presenter: CategoriesPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120

        tableView.register(CategoriesCell.self, forCellReuseIdentifier: CategoriesCell.reuseId)
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.reuseId, for: indexPath) as! CategoriesCell
        cell.backgroundColor = .blue
        return cell
    }

}

// MARK: - Binding
extension CategoriesTableViewController: CategoriesViewProtocol {
    
}
